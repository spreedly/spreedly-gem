require 'test_helper'

class RemoteAddGatewayTest < Test::Unit::TestCase

  # TODO We'll add more to this soon.

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    environment = Spreedly::Environment.new("UnknownEnvironmentKey", "UnknownAccessSecret")

    error = assert_raises(Spreedly::AuthenticationError) { environment.add_gateway(:test) }
    assert_equal "Unable to authenticate using the given access_token.", error.message
  end

  def test_non_existent_gateway_type
    error = assert_raises(Spreedly::TransactionCreationError) { @environment.add_gateway(:non_existent) }
    assert_equal "The gateway_type parameter is invalid.", error.message
  end

  def test_add_test_gateway
    gateway = @environment.add_gateway(:test)
    assert_equal "test", gateway.gateway_type
    assert_equal "retained", gateway.state
    assert_equal "Test", gateway.name
  end

end
