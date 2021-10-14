source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "active_model_serializers", "~> 0.10.0"
gem "coffee-rails", "~> 4.2"
gem "foundation-rails"
gem "font-awesome-rails"
gem "haml"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "omniauth-github", "~> 1.4"
gem "omniauth-launch-pass",
  github: "launchacademy/omniauth-launch-pass"
gem "pg", "~> 1.0"
gem "puma", "~> 3.0"
gem "rails", "~> 5.0.1"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "dotenv-rails"
  gem "pry-rails"
  gem "rails_real_favicon"
  gem "rspec-rails"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara"
  gem "capybara-email"
  gem "coveralls", require: false
  gem "factory_girl_rails"
  gem "launchy"
  gem "shoulda-matchers"
  gem "valid_attribute"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby "2.6.6"
