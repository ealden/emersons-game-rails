source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.3'

gem 'rails', '~> 7.1.0'
gem 'sprockets-rails'
# gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 6.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
# gem 'redis', '~> 4.0'
# gem 'kredis'
# gem 'bcrypt', '~> 3.1.7'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap', require: false
gem 'sassc-rails'
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]

  gem 'sqlite3', '~> 1.4'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console'
  # gem 'rack-mini-profiler'
  # gem 'spring'

  gem 'rubocop', require: false
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'

  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'site_prism'
end

group :production do
  gem 'pg'
end
