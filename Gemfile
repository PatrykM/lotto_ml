source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.6.1'
# Moingoid for MongoDB
gem 'mongoid'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'execjs'
gem 'therubyracer', platforms: :ruby
# Use Uglifier as compressor for JavaScript assets
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Haml to be faster
gem 'haml'
# ai4r machine learning algorithms for ruby
gem 'ai4r'
# another library for nn
gem 'ruby-fann'
# Pagination gems
gem 'kaminari'
gem 'kaminari-actionview'
gem 'kaminari-mongoid'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Static code analyzer
gem 'concurrent-ruby'
gem 'rubocop', require: false
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and
  # get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  #gem 'capybara', '~> 2.13'
  #gem 'selenium-webdriver'
  # For testing web connections
  gem 'webmock'
  # Rspec
  gem 'rspec-rails'
  # Rspec controller testing
  gem 'rails-controller-testing'
  # FactoryGirl
  gem 'factory_girl_rails'
  # Detecting code smells
  gem 'reek'
  # Shoulda matchers
  gem 'shoulda-matchers', '~> 3.0'
end
group :development do
  # Access an IRB console on exception pages or by using
  # <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  #gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
