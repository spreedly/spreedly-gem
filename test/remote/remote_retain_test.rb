require 'test_helper'

class RemoteRetainTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.retain_payment_method('payment_method_token')
    end
  end

  def test_payment_method_token_token_not_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified payment method.") do
      @environment.retain_payment_method('unknown_token')
    end
  end

  def test_successful_retain
    card_token = create_card_on(@environment, retained: false).token

    transaction = @environment.retain_payment_method(card_token)
    assert transaction.succeeded?
    assert_equal "Succeeded!", transaction.message
    assert_equal 'retained', transaction.payment_method.storage_state
  end

  def test_failed_retain
    card_token = create_card_on(@environment).token
    @environment.redact_payment_method(card_token)

    transaction = @environment.retain_payment_method(card_token)
    assert !transaction.succeeded?
    assert_equal "The payment method has been redacted. Therefore, it cannot be retained.", transaction.message
  end

end
