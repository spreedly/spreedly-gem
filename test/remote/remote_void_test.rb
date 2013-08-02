require 'test_helper'

class RemoteVoidTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.void_transaction('transaction_token')
    end
  end

  def test_transaction_token_not_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified reference transaction.") do
      @environment.void_transaction('unknown_transaction')
    end
  end

  def test_needs_succeeded_reference
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_failed_card_on(@environment).token
    transaction = @environment.purchase_on_gateway(gateway_token, card_token, 144)
    assert !transaction.succeeded?

    assert_raise_with_message(Spreedly::TransactionCreationError, "The reference transaction did not succeed. Only successful reference transactions are permitted.") do
      @environment.void_transaction(transaction.token)
    end
  end

  def test_successful_void
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token
    purchase = @environment.purchase_on_gateway(gateway_token, card_token, 144)
    assert purchase.succeeded?

    void = @environment.void_transaction(purchase.token)
    assert void.succeeded?
    assert_equal "Succeeded!", void.message
    assert_equal gateway_token, void.gateway_token
  end


end
