require 'test_helper'

class RemoteOffsitePurchaseTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.purchase_on_gateway('gtoken', 'ptoken', 100)
    end
  end

  def test_payment_method_not_found
    assert_raise_with_message(Spreedly::TransactionCreationError, "There is no payment method corresponding to the specified payment method token.") do
      @environment.purchase_on_gateway('gateway_token', 'unknown_payment_method', 100)
    end
  end

  def test_gateway_not_found
    payment_method_token = create_offsite_payment_method_on(@environment).token
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified gateway.") do
      @environment.purchase_on_gateway('unknown_gateway', payment_method_token, 100)
    end
  end

  def test_successful_purchase
    gateway_token = @environment.add_gateway(:test).token
    payment_method_token = create_offsite_payment_method_on(@environment).token

    options = { callback_url: 'http://callback.com', redirect_url: 'http://redirect.com' }
    transaction = @environment.purchase_on_gateway(gateway_token, payment_method_token, 100, options)
    assert !transaction.succeeded?
    assert_equal payment_method_token, transaction.payment_method.token
    assert_equal 100, transaction.amount
    assert transaction.response.checkout_url.start_with?("https://core.spreedly.com/sprel")
  end

  def test_failed_purchase
    gateway_token = @environment.add_gateway(:test).token
    payment_method_token = create_offsite_payment_method_on(@environment).token

    # blank callback url to simulate failure
    options = { callback_url: '', redirect_url: 'http://redirect.com' }

    assert_raise_with_message(Spreedly::TransactionCreationError, "Callback url can't be blank") do
      @environment.purchase_on_gateway(gateway_token, payment_method_token, 100, options)
    end
  end

end
