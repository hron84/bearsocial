source 'https://rubygems.org'

gem 'rails', '~> 3.2.13'
gem 'rails-i18n'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'blueprint-rails'

  gem 'twitter-bootstrap-rails'

  gem 'uglifier'
  gem 'jquery-rails'
end

group :test do
  gem 'rspec-rails', :require => false
  gem 'cucumber-rails', :require => false

  gem 'factory_girl', '~> 2.6.1'
  gem 'factory_girl_rails'

  gem 'database_cleaner'

  gem 'simplecov'
end

group :development do
  gem 'sqlite3'
  
  gem 'binding_of_caller', :platform => :ruby_19
  gem 'better_errors', :platform => :ruby_19

  gem 'guard', require: false
  gem 'guard-pow', require: false
  gem 'guard-rails', require: false
  gem 'guard-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'guard-cucumber', require: false
  gem 'guard-spork', :require => false

  gem 'spork'

  gem 'rb-inotify', '~> 0.9', require: false

  gem 'pry'
  gem 'pry-rails'
  
  gem 'thin'
end

group :production do
  gem 'pg'

  gem 'rack-protection'
  gem 'exception_notification'

  gem 'thin'
end

group :app do
  gem 'squeel'

  gem 'haml-rails'
  gem 'redcarpet'
  
  gem 'inherited_resources'
  gem 'kaminari'
  gem 'twitter_bootstrap_form_for', :github => 'hron84/twitter_bootstrap_form_for', :branch => 'develop'

  gem 'bcrypt-ruby'
  gem 'devise'
  gem 'devise-encryptable'
  gem 'devise-i18n'

  gem 'cancan'

  gem 'magic-localized_country_select', :github => 'hron84/localized_country_select', :branch => 'fix-rails-select', :require => 'localized_country_select'

  gem 'strong_parameters'
end

group :deployment do
  gem 'heroku'
end

group :background_tasks do
  gem 'resque'
end
