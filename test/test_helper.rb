require 'test/unit'
require 'mocha/test_unit'
require 'awesome_print'
require 'pry'
require 'logger'
require 'log_buddy'
require 'spreedly'
require 'credentials/test_credentials'
require 'helpers/stub_response'
require 'helpers/creation_helper'
require 'helpers/assertions'
require 'helpers/communication_helper'

LogBuddy.init(use_awesome_print: true, logger: Logger.new(nil))


Test::Unit::TestCase.class_eval do
  include Spreedly::TestCredentials
  include Spreedly::CreationHelper
  include Spreedly::Assertions
  include Spreedly::CommunicationHelper
end

