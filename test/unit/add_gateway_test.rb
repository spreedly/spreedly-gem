require 'test_helper'
require 'unit/response_stubs/add_gateway_stubs'

class AddGatewayTest < Test::Unit::TestCase

  include AddGatewayStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_add_test_gateway
    @environment.stubs(:raw_ssl_request).returns(successful_add_test_gateway_response)

    gateway = @environment.add_gateway(:test)
    assert_equal "4dFb93AiRDEJ18MS9xDGMyu22uO", gateway.token
    assert_equal "test", gateway.gateway_type
    assert_equal "retained", gateway.state
    assert_equal "Test", gateway.name
  end

  # TODO
  # Tests coming for characteristics, payment_methods, and gateway_specific_fields.
  # We'll also soon handle adding other types of gateways.

end
