RAILS_ROOT = File.expand_path('..', File.dirname(__FILE__))

cookbook_path %W(#{RAILS_ROOT}/cookbooks #{RAILS_ROOT}/cookbooks-local)
file_cache_path '/tmp/chef-solo'
