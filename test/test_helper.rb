
require 'test/unit'
require 'mocha/setup'
require 'awesome_print'
require 'logger'
require 'log_buddy'
require 'spreedly'
require 'credentials/test_credentials'

LogBuddy.init(use_awesome_print: true, logger: Logger.new(nil))


Test::Unit::TestCase.class_eval do
  include Spreedly::TestCredentials
end

