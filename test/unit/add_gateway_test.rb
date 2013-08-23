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
    assert_equal("4dFb93AiRDEJ18MS9xDGMyu22uO", gateway.token)
    assert_equal("test", gateway.gateway_type)
    assert_equal("retained", gateway.state)
    assert_equal("Test", gateway.name)
    assert_equal({}, gateway.credentials)
  end

  def test_request_body_params
    body = get_request_body(successful_add_test_gateway_response) do
      @environment.add_gateway(:wirecard, username: "TheUserName", password: "ThePassword", business_case_signature: "TheSig")
    end

    gateway = body.xpath('./gateway')
    assert_xpaths_in gateway,
      [ './gateway_type', 'wirecard' ],
      [ './username', 'TheUserName' ],
      [ './password', 'ThePassword' ],
      [ './business_case_signature', 'TheSig']
  end

end
