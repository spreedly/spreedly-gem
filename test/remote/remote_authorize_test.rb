require 'test_helper'

class RemoteAuthorizeTest < Test::Unit::TestCase
  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.authorize_on_gateway('gtoken', 'ptoken', 100)
    end
  end

  def test_payment_method_not_found
    assert_raise_with_message(Spreedly::NotFoundError, "There is no payment method corresponding to the specified payment method token.") do
      @environment.authorize_on_gateway(remote_test_gateway_token, 'unknown_payment_method', 100)
    end
  end

  def test_gateway_not_found
    card_token = create_card_on(@environment).token
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified gateway.") do
      @environment.authorize_on_gateway('unknown_gateway', card_token, 100)
    end
  end

  def test_successful_authorize
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    transaction = @environment.authorize_on_gateway(gateway_token, card_token, 899)
    assert transaction.succeeded?
    assert_equal card_token, transaction.payment_method.token
    assert_equal 899, transaction.amount
  end

  def test_successful_authorize_with_stored_credentials
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    transaction = @environment.authorize_on_gateway(
      gateway_token,
      card_token,
      899,
      stored_credential_initiator: :merchant,
      stored_credential_reason_type: :installment
    )

    assert transaction.succeeded?
    assert_equal 'merchant', transaction.stored_credential_initiator
    assert_equal 'installment', transaction.stored_credential_reason_type
  end

  def test_failed_authorize
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_failed_card_on(@environment).token

    transaction = @environment.authorize_on_gateway(gateway_token, card_token, 144)
    assert !transaction.succeeded?
    assert_equal "Unable to process the authorize transaction.", transaction.message
    assert_equal gateway_token, transaction.gateway_token
  end
end
