source 'https://rubygems.org'
ruby '2.5.0'

# =======================
# CONFIG 
# =======================

# Local ENV variables for testing & development
gem 'dotenv-rails', :groups => [:development, :test]
# cloudfoundry utils
gem 'cf-app-utils'
# http://docs.cloudfoundry.org/buildpacks/ruby/ruby-tips.html#rails-4
gem 'rails_serve_static_assets'
# https://github.com/heroku/rails_stdout_logging
gem 'rails_stdout_logging'

# =======================
# RAILS CORE
# =======================

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.21.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7.0'
# bundle exec rake doc:rails generates the API under doc/api.
#gem 'sdoc', '~> 0.4.1',          group: :doc
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
# Makes running Rails easier - based on 12factor.net
gem 'rails_12factor', group: :production

# =======================
# AUTH & SOCIAL LOGINS
# =======================

# The Core Rails Authentication system
gem 'devise'
# Standardized auth system
gem 'omniauth'
# Use Google APIs and google auth
# https://developers.google.com/api-client-library/ruby/auth/web-app#offline
gem 'google-api-client'
gem "omniauth-google-oauth2"
# Access control
gem "cancancan"

# =======================
# APIs
# =======================

# Slack Support For Notifications https://github.com/rikas/slack-poster
gem 'slack-poster'
# http request wrapper https://github.com/rest-client/rest-client
gem 'rest-client'
# =======================
# UI GEMS
# =======================
gem 'haml'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.7.0'
# Compress css to inline styles for HTML emails
gem 'roadie-rails'

# =======================
# JOB QUEUE GEMS
# =======================
# Uses PostgreSQL "advisory locks" for maximum reliability
# https://github.com/chanks/que/blob/master/docs/writing_reliable_jobs.md
gem 'que'


# =======================
# TESTING
# =======================
group :development do
  # better error page
  gem "better_errors"
  gem "binding_of_caller"
  gem 'rubyzip', '>= 1.2.1'
end
group :development, :test do
	# Test Framework we are using
  gem "rspec-rails", "~> 3.7.2"
  # Fixtures replacement
  gem "factory_bot_rails", "~> 4.8.2"
  # Make sure seeds only run in development
  gem "seedbank"
end

group :test do
  #junit formatter
  gem 'rspec_junit_formatter', '0.2.2'
  gem "rspec-collection_matchers"
	# Fake data generator
  gem "faker", "~> 1.6.0"
  # Simulate User Interactions
  gem "capybara", "~> 2.5.0"
  # Easily reset db between tests
  gem "database_cleaner", "~> 1.5.0"
  # code coverage reporting
  gem 'simplecov'

  # Open web browser from test suite
  #gem "launchy", "~> 2.4.0"
  # Test JS browser interactions
  #gem "selenium-webdriver", "~> 2.48.0"
end

# =======================
# DEPLOYMENT
# =======================

gem 'capistrano', '~> 3.4.0'
# high performance http rack server
gem 'puma'
# analytics
gem 'prometheus-client'
# web application firewall
gem 'rack-protection'
# caching
gem 'rack-cache'
# ssl redirect
gem 'rack-ssl'
#debugging
gem 'rollbar', '~> 2.15.5'
gem 'oj', '~> 3.4.0'

# =======================
# LIVE RELOAD FOR DEVELOPMENT
# =======================

group :development do
  gem 'guard',            '~> 2.14.0',  :require => false
  gem 'guard-livereload', '~> 2.5.0',   :require => false
  gem 'rack-livereload',  '~> 0.3.16'
  gem 'rb-fsevent',       '~> 0.9.6',   :require => false
end
