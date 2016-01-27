require 'test_helper'

class RemotePurchaseTest < Test::Unit::TestCase

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
    card_token = create_card_on(@environment).token
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified gateway.") do
      @environment.purchase_on_gateway('unknown_gateway', card_token, 100)
    end
  end

  def test_successful_purchase
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    transaction = @environment.purchase_on_gateway(gateway_token, card_token, 144)
    assert transaction.succeeded?
    assert_equal card_token, transaction.payment_method.token
    assert_equal 144, transaction.amount
  end

  def test_failed_purchase
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_failed_card_on(@environment).token

    transaction = @environment.purchase_on_gateway(gateway_token, card_token, 144)
    assert !transaction.succeeded?
    assert_equal "Unable to process the purchase transaction.", transaction.message
    assert_equal gateway_token, transaction.gateway_token
  end

  def test_optional_arguments
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment, retained: false).token

    transaction = @environment.purchase_on_gateway(gateway_token, card_token, 344,
                                                   order_id: "8675",
                                                   description: "SuperDuper",
                                                   ip: "183.128.100.103",
                                                   email: "fred@example.com",
                                                   merchant_name_descriptor: "Real Stuff",
                                                   merchant_location_descriptor: "Raleigh",
                                                   retain_on_success: true)

    assert transaction.succeeded?
    assert_equal "8675", transaction.order_id
    assert_equal "SuperDuper", transaction.description
    assert_equal "183.128.100.103", transaction.ip
    assert_equal "Real Stuff", transaction.merchant_name_descriptor
    assert_equal "Raleigh", transaction.merchant_location_descriptor
    assert_equal "cached", transaction.payment_method.storage_state
    assert_equal "fred@example.com", transaction.email
    assert_equal "perrin@wot.com", transaction.payment_method.email
    assert_match /\d/, transaction.gateway_transaction_id
    assert_match "Purchase", transaction.transaction_type
  end

  def test_gateway_specific_fields
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment, retained: false).token

    t = @environment.purchase_on_gateway(gateway_token, card_token, 344,
          gateway_specific_fields:
            {
              litle: {
                descriptor_name: "CompanyName",
                descriptor_phone: "1331131131"
              },
              stripe: {
                application_fee: 411
              }
            })

    assert t.succeeded?
    assert_equal "CompanyName", t.gateway_specific_fields[:litle][:descriptor_name]
    assert_equal "411", t.gateway_specific_fields[:stripe][:application_fee]
  end

end
