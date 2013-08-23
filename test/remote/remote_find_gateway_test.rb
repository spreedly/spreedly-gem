require 'test_helper'

class RemoteFindGatewayTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.find_gateway("SomeToken")
    end
  end

  def test_gateway_not_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified gateway.") do
       @environment.find_gateway("SomeUnknownToken")
    end
  end

  def test_successfully_find_gateway
    gateway = @environment.add_gateway(:test)

    found = @environment.find_gateway(gateway.token)

    assert_equal(gateway.token, found.token)
    assert_equal("Spreedly Test", gateway.name)
    assert_equal("retained", gateway.state)
    assert_equal({}, gateway.credentials)
  end

end
