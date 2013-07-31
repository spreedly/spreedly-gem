
require 'test/unit'
require 'mocha/setup'
require 'awesome_print'
require 'logger'
require 'log_buddy'
require 'spreedly'
require 'credentials/test_credentials'
require 'helpers/stub_response'
require 'helpers/creation_helpers'
require 'helpers/assertions'

LogBuddy.init(use_awesome_print: true, logger: Logger.new(nil))


Test::Unit::TestCase.class_eval do
  include Spreedly::TestCredentials
  include Spreedly::CreationHelpers
  include Spreedly::Assertions
end

