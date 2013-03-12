source 'https://rubygems.org'

gem 'rails', '~> 3.2.4'
gem 'rails-i18n'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'blueprint-rails'

  gem 'twitter-bootstrap-rails'

  gem 'uglifier'
  gem 'jquery-rails'
  gem 'facebox-rails'
end

group :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'

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

  gem 'rb-inotify', '~> 0.9', require: false

  gem 'pry'
  gem 'pry-rails'
  
  gem 'thin'

  gem 'vagrant', :require => false
end

group :production do
  gem 'pg'

  gem 'rack-protection'

  gem 'unicorn'
end

group :app do
  gem 'haml-rails'
  gem 'redcarpet'
  
  gem 'inherited_resources'
  gem 'kaminari'
  gem 'formtastic'

  gem 'devise'
  # gem 'devise-encryptable'
  gem 'devise-i18n'

  gem 'social_stream', '~> 1.0.0'

  gem 'strong_parameters'
end

group :deployment do
  gem 'heroku', :require => false
end

group :background_tasks do
  gem 'resque'
end
