require 'test_helper'

class RemoteRefundTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.refund_transaction('authorize_token')
    end
  end

  def test_transaction_token_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified reference transaction.") do
      @environment.refund_transaction('unknown_transaction_token')
    end
  end

  def test_needs_succeeded_reference
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_failed_card_on(@environment).token
    purchase = @environment.purchase_on_gateway(gateway_token, card_token, 144)
    assert !purchase.succeeded?

    assert_raise_with_message(Spreedly::TransactionCreationError, "The reference transaction did not succeed. Only successful reference transactions are permitted.") do
      @environment.refund_transaction(purchase.token)
    end
  end

  def test_successful_refund_full_amount
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token
    purchase = @environment.purchase_on_gateway(gateway_token, card_token, 944)

    refund = @environment.refund_transaction(purchase.token)
    assert refund.succeeded?
    assert_equal purchase.token, refund.reference_token
    assert_equal 944, refund.amount
  end

  def test_successful_refund_partial_amount
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token
    purchase = @environment.purchase_on_gateway(gateway_token, card_token, 1944)

    refund = @environment.refund_transaction(purchase.token, amount: 323)
    assert refund.succeeded?
    assert_equal 323, refund.amount
  end

  def test_failed_refund
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token
    purchase = @environment.purchase_on_gateway(gateway_token, card_token, 1944)

    refund = @environment.refund_transaction(purchase.token, amount: 44)
    assert !refund.succeeded?
    assert_equal purchase.token, refund.reference_token
    assert_equal 44, refund.amount
    assert_equal 'Unable to process the credit transaction.', refund.message
  end

end
