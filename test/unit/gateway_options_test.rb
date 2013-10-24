require 'test_helper'
require 'unit/response_stubs/gateway_options_stubs'

class ListGatewaysTest < Test::Unit::TestCase

  include GatewayOptionsStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_gateway_options
    @environment.stubs(:raw_ssl_request).returns(successful_gateway_options_response)
    list = @environment.gateway_options

    assert_kind_of(Array, list)
    assert_equal 2, list.size

    assert_equal 'PayPal', list.first.name
    assert_equal ["US", "GB", "CA"], list.first.supported_countries
    assert_equal ["credit_card", "paypal"], list.first.payment_methods
    assert_equal "paypal", list.first.gateway_type
    assert_equal "http://paypal.com/", list.first.homepage
    assert_kind_of Spreedly::GatewayClass, list.first
    assert_kind_of Spreedly::GatewayClass, list.last
  end

  def test_successful_gateway_options_with_argument
    @environment.stubs(:raw_ssl_request).returns(successful_gateway_options_response)
    result = @environment.gateway_options("paypal")

    assert_kind_of Spreedly::GatewayClass, result
    assert_equal "paypal", result.gateway_type

    invalid_result = @environment.gateway_options("paypal2")
    assert_equal nil, invalid_result
  end
end
