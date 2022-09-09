require 'test_helper'

class RemoteListTransactionsTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.list_transactions
    end
  end

  def test_successfully_list_transactions
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    t1 = @environment.purchase_on_gateway(gateway_token, card_token, 144)
    t2 = @environment.authorize_on_gateway(gateway_token, card_token, 444)
    t3 = @environment.capture_transaction(t2.token, amount: 22)

    first_twenty = @environment.list_transactions
    assert_equal 20, first_twenty.size
    assert_kind_of Spreedly::Model, first_twenty.first

    transactions = @environment.list_transactions(t2.token)
p transactions
    assert_equal 1, transactions.size
    assert_kind_of(Spreedly::Authorization, transactions.first)
    assert_kind_of(Spreedly::Capture, transactions.last)

    assert_equal 444, transactions.first.amount
    assert_equal 22, transactions.last.amount
  end

  def test_successfully_list_transactions_for_a_payment_method
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    t1 = @environment.purchase_on_gateway(gateway_token, card_token, 144)
    t2 = @environment.authorize_on_gateway(gateway_token, card_token, 444)
    t3 = @environment.capture_transaction(t2.token, amount: 22)

    all = @environment.list_transactions(nil, card_token)
    assert_equal 5, all.size
    assert_kind_of Spreedly::Model, all.first

    next_group = @environment.list_transactions(t1.token, card_token)
    assert_equal 2, next_group.size
    assert_kind_of(Spreedly::Authorization, next_group.first)
    assert_kind_of(Spreedly::Capture, next_group.last)

    assert_equal 444, next_group.first.amount
    assert_equal 22, next_group.last.amount
  end

  def test_list_transactions_non_existent_payment_method
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified payment method.") do
       @environment.list_transactions(nil, 'nonExistentToken')
    end
  end

end

