ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "mocha/mini_test"
require "simplecov"

SimpleCov.start("rails")

class ActiveSupport::TestCase

  class ActionDispatch::IntegrationTest
    include Capybara::DSL
    include FactoryGirl::Syntax::Methods

    def teardown
      reset_session!
    end
  end

  DatabaseCleaner.strategy = :transaction

  class Minitest::Spec
    def setup
      DatabaseCleaner.start
    end

    def teardown
      DatabaseCleaner.clean
    end
  end
end
