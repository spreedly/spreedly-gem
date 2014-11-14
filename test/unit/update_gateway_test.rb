require 'test_helper'
require 'unit/response_stubs/update_gateway_stubs'

class UpdateGatewayTest < Test::Unit::TestCase

  include UpdateGatewayStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_update_gateway
    @environment.stubs(:raw_ssl_request).returns(successful_update_gateway_response)

    gateway = @environment.update_gateway('E5P4BwEtgyvoUEMfnZ7KV2vIM8b', login: 'newlogin', password: 'newpassword')
    assert_equal("E5P4BwEtgyvoUEMfnZ7KV2vIM8b", gateway.token)
    assert_equal({'login' => 'newlogin'}, gateway.credentials)
  end

  def test_request_body_params
    body = get_request_body(successful_update_gateway_response) do
      @environment.update_gateway('E5P4BwEtgyvoUEMfnZ7KV2vIM8b', login: 'newlogin', password: 'newpassword')
    end

    gateway = body.xpath('./gateway')
    assert_xpaths_in gateway,
      [ './login', 'newlogin' ],
      [ './password', 'newpassword' ]
  end
end
