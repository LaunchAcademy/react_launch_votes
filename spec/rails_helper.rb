ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"
require "capybara/rspec"
require "capybara/email/rspec"
require "factory_girl"
require "omniauth-github"
require "shoulda-matchers"
require "valid_attribute"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.before(:each) do
    OmniAuth.config.mock_auth[:github] = nil
    OmniAuth.config.mock_auth[:launch_pass] = nil
  end
  config.include AuthenticationHelpers
  config.include FactoryGirl::Syntax::Methods
  config.filter_rails_from_backtrace!
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  OmniAuth.config.test_mode = true
end
