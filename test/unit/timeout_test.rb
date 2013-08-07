require 'test_helper'
require 'unit/response_stubs/void_stubs'

class TimeoutTest < Test::Unit::TestCase

  include VoidStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_timeout
    @environment.stubs(:raw_ssl_request).raises(Timeout::Error)

    assert_raise_with_message(Spreedly::TimeoutError, "The payment system is not responding.") do
      @environment.void_transaction('NotImportantSinceStubbed')
    end
  end

end
