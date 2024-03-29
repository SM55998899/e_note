source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "7.0.4"
gem "ransack"
gem "image_processing", "1.12.2"
gem "active_storage_validations", "0.9.8"
gem "bcrypt", "3.1.18"
gem "faker", "2.21.0"
gem "will_paginate", "3.3.1"
gem "bootstrap-will_paginate", "1.0.0"
gem "bootstrap-sass", "3.4.1"
gem "sassc-rails", "2.1.2"
gem "sprockets-rails", "3.4.2"
gem "importmap-rails", "1.1.0"
gem "turbo-rails", "1.1.1"
gem "stimulus-rails", "1.0.4"
gem "jbuilder", "2.11.5"
gem "puma", "5.6.4"
gem "bootsnap", "1.12.0", require: false
gem "rails-i18n"
gem "dotenv"

group :development, :test do
  gem "mysql2"
  gem "debug", "1.5.0", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "guard-rspec", require: false
  gem "rspec_junit_formatter"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console", "4.2.0"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
end

group :test do
  gem "capybara", "3.37.1"
  gem "selenium-webdriver", "4.2.0"
  gem "rails-controller-testing", "1.0.5"
  gem "minitest", "5.15.0"
  gem "minitest-reporters", "1.5.0"
  gem "guard", "2.18.0"
  gem "guard-minitest", "2.4.6"
  gem "webdrivers"
  gem "rspec-rails"
  gem "spring-commands-rspec"
  gem "factory_bot_rails"
  gem "database_cleaner"
  gem "launchy"
end

group :production do
  gem "aws-sdk-s3", "1.114.0", require: false
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "erb-formatter", "~> 0.4.1"

gem "dockerfile-rails", ">= 1.0", :group => :development
