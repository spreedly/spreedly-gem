require 'test_helper'

class RemoteAddGatewayTest < Test::Unit::TestCase

  # TODO We'll add more to this soon.

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.add_gateway(:test)
    end
  end

  def test_non_existent_gateway_type
    assert_raise_with_message(Spreedly::TransactionCreationError, "The gateway_type parameter is invalid.") do
      @environment.add_gateway(:non_existent)
    end
  end

  def test_add_test_gateway
    gateway = @environment.add_gateway(:test)
    assert_equal "test", gateway.gateway_type
    assert_equal "retained", gateway.state
    assert_equal "Test", gateway.name
  end

end
