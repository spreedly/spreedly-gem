require 'test_helper'

class RemoteStoreTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.store_on_gateway('gtoken', 'ptoken')
    end
  end

  def test_payment_method_not_found
    assert_raise_with_message(Spreedly::TransactionCreationError, "There is no payment method corresponding to the specified payment method token.") do
      @environment.store_on_gateway('gateway_token', 'unknown_payment_method')
    end
  end

  def test_gateway_not_found
    card_token = create_card_on(@environment).token
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified gateway.") do
      @environment.store_on_gateway('unknown_gateway', card_token)
    end
  end

  def test_successful_store
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    transaction = @environment.store_on_gateway(gateway_token, card_token)
    assert transaction.succeeded?
    assert_equal card_token, transaction.basis_payment_method.token
    assert transaction.payment_method.third_party_token
  end

  def test_failed_store
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment, number: "4217651111111119").token

    transaction = @environment.store_on_gateway(gateway_token, card_token)
    assert !transaction.succeeded?
    assert_equal "Unable to store card", transaction.message
  end

end
