require 'test_helper'

class RemoteTransactionsTest < Test::Unit::TestCase

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

    transactions = @environment.list_transactions(t1.token)
    assert_equal 2, transactions.size
    assert_kind_of(Spreedly::Authorization, transactions.first)
    assert_kind_of(Spreedly::Capture, transactions.last)

    assert_equal 444, transactions.first.amount
    assert_equal 22, transactions.last.amount
  end

end
