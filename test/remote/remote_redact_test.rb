require 'test_helper'

class RemoteRedactTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.redact_payment_method('payment_method_token')
    end
  end

  def test_payment_method_token_token_not_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified payment method.") do
      @environment.redact_payment_method('unknown_token')
    end
  end

  def test_successful_redact
    card_token = create_card_on(@environment).token

    transaction = @environment.redact_payment_method(card_token)

    assert transaction.succeeded?
    assert_equal 'redacted', transaction.payment_method.storage_state
  end

  def test_remove_from_gateway_unknown_gateway
    card_token = create_card_on(@environment).token

    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified gateway.") do
      transaction = @environment.redact_payment_method(card_token, remove_from_gateway: 'unknown_token')
    end
  end

end
