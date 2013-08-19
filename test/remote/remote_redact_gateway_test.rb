require 'test_helper'

class RemoteRedactGatewayTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.redact_gateway('gateway_token')
    end
  end

  def test_gateway_token_token_not_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified gateway.") do
      @environment.redact_gateway('unknown_token')
    end
  end

  def test_successful_redact
    gateway = @environment.add_gateway(:test)

    transaction = @environment.redact_gateway(gateway.token)

    assert transaction.succeeded?
    assert_equal 'redacted', transaction.gateway.state
  end

end
