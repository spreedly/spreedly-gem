require 'test_helper'
require 'unit/response_stubs/receiver_options_stubs'

class ReceiverOptionsTest < Test::Unit::TestCase

  include ReceiverOptionsStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_receiver_options
    @environment.stubs(:raw_ssl_request).returns(successful_receiver_options_response)
    list = @environment.receiver_options

    assert_kind_of(Array, list)
    assert_equal 2, list.size

    assert_equal 'test', list.first.receiver_type
    assert_equal 'Api', list.first.name
    assert_equal "http://api.example.com/post", list.first.hostnames
    assert_equal "The Example API", list.first.company_name
    assert_equal 'test', list.last.receiver_type
    assert_equal 'Funny', list.last.name
    assert_equal "http://funny.pretend.example.com", list.last.hostnames
    assert_equal "Funny Pretend", list.last.company_name
    assert_kind_of Spreedly::ReceiverClass, list.first
    assert_kind_of Spreedly::ReceiverClass, list.last
  end

end
