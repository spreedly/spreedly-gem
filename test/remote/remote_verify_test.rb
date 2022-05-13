require 'test_helper'

class RemoteVerifyTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.verify_on_gateway('gtoken', 'ptoken')
    end
  end

  def test_payment_method_not_found
    assert_raise_with_message(Spreedly::TransactionCreationError, "There is no payment method corresponding to the specified payment method token.") do
      @environment.verify_on_gateway('gateway_token', 'unknown_payment_method')
    end
  end

  def test_gateway_not_found
    card_token = create_card_on(@environment).token
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified gateway.") do
      @environment.verify_on_gateway('unknown_gateway', card_token)
    end
  end

  def test_successful_verify
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    transaction = @environment.verify_on_gateway(gateway_token, card_token)
    assert transaction.succeeded?
    assert_equal card_token, transaction.payment_method.token
    assert_equal gateway_token, transaction.gateway_token
  end

  def test_successful_verify_with_stored_credentials
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    transaction = @environment.verify_on_gateway(
      gateway_token,
      card_token,
      stored_credential_initiator: :merchant,
      stored_credential_reason_type: :unscheduled
    )

    assert transaction.succeeded?
    assert_equal 'merchant', transaction.stored_credential_initiator
    assert_equal 'unscheduled', transaction.stored_credential_reason_type
  end

  def test_failed_verify
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_failed_card_on(@environment).token

    transaction = @environment.verify_on_gateway(gateway_token, card_token)
    assert !transaction.succeeded?
    assert_equal "Unable to process the verify transaction.", transaction.message
    assert_equal gateway_token, transaction.gateway_token
  end

end
