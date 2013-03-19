#
# Cookbook Name:: jbsocial
# Recipe:: default
#
# Copyright 2013, Gabor Garami
#
# Licensed under the terms of CreativeCommons BY-NC-SA 3.0
# See LICENSE file for details
#

%w(libmagickcore-dev libmagickwand-dev imagemagick libsndfile1-dev nodejs).each { |pkg| package pkg }


cookbook_file "#{node['nginx']['dir']}/sites-available/jbsocial.hron.me" do
  source "jbsocial.conf"
  notifies :reload, 'service[nginx]'
end

template "/vagrant/config/database.yml" do
  source 'database.yml.erb'
end

nginx_site 'jbsocial.hron.me' do
  enable true
end

pg_connection_info = {
  :host => '127.0.0.1',
  :user => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

database 'jbsocial_production' do
  provider Chef::Provider::Database::Postgresql
  connection pg_connection_info
  action :create
end

database_user 'jbsocial' do
  provider Chef::Provider::Database::PostgresqlUser
  connection pg_connection_info
  password node['postgresql']['password']['jbsocial'] # Using same bucket
  action :create
end

jbs_ruby_str = 'ruby-1.9.3-p392@jbsocial'
  
rvm_gemset jbs_ruby_str do
  user 'vagrant'
  action :create
end

def bexec(cmd, product=nil)
  rvm_shell "#{cmd}" do
    ruby_string jbs_ruby_str
    user 'vagrant'
    cwd  '/vagrant'
    environment({ 'RAILS_ENV' => 'production' })
    code "bundle exec #{cmd}"
    creates product if product
  end
end

def brake(task, product=nil)
  rvm_shell "rake #{task}" do
    ruby_string jbs_ruby_str
    user 'vagrant'
    cwd  '/vagrant'
    environment({ 'RAILS_ENV' => 'production' })
    code "bundle exec rake #{task}"
    creates product if product
  end
end


if File.exists?('/vagrant/Vagrantfile')
  rvm_shell 'bundle_install' do
    ruby_string jbs_ruby_str
    user 'vagrant'
    cwd  '/vagrant'
    code 'bundle install --without development test'
  end

  rvm_wrapper 'bootup' do
    ruby_string jbs_ruby_str
    binary 'puma'
    user 'vagrant'
    action :create
  end

  #rvm_shell 'rake db:setup' do
  #  ruby_string jbs_ruby_str
  #  user 'vagrant'
  #  cwd  '/vagrant'
  #  code 'bundle exec rake RAILS_ENV=production db:setup'
  #end

  brake 'tmp:create', '/vagrant/tmp/pids'
  brake 'db:setup'

  #rvm_shell 'rake assets:precompile' do
  #  ruby_string jbs_ruby_str
  #  user 'vagrant'
  #  cwd  '/vagrant'
  #  code 'bundle exec rake RAILS_ENV=production assets:precompile'
  #  creates '/vagrant/public/assets/manifest.yml'
  #end
  brake 'assets:precompile', '/vagrant/public/assets/manifest.yml'

  #rvm_shell 'puma_start' do
  #  ruby_string jbs_ruby_str
  #  user 'vagrant'
  #  cwd  '/vagrant'
  #  code 'bundle exec /vagrant/script/puma start'
  #end
  bexec "thin restart -C config/thin.yml"
end
