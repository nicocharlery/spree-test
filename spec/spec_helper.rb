ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'ffaker'
require 'spree/core/testing_support/factories'
require 'spree/core/testing_support/controller_requests'
require 'spree/core/testing_support/authorization_helpers'
require 'spree/core/url_helpers'

# local files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::Core::UrlHelpers
  config.include Spree::Core::TestingSupport::ControllerRequests
  config.include Devise::TestHelpers, :type => :controller
end

__END__

  config.include Spree::Core::TestingSupport::ControllerRequests, :type => :controller
  config.color = true
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
end
