require 'test_helper'

class RemoteRecachePaymentMethodTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.recache_payment_method('payment_method_token')
    end
  end

  def test_payment_method_token_token_not_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified payment method.") do
      @environment.recache_payment_method('unknown_token')
    end
  end

  def test_successful_recache
    card_token = create_card_on(@environment).token

    transaction = @environment.recache_payment_method(card_token, verification_value: '123')

    assert transaction.succeeded?
    assert_equal 'retained', transaction.payment_method.storage_state
  end

end
