require 'test_helper'
require 'unit/response_stubs/purchase_stubs'

class PurchaseTest < Test::Unit::TestCase

  include PurchaseStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_purchase
    t = purchase_using(successful_purchase_response)

    assert_kind_of(Spreedly::Purchase, t)
    assert_equal 'Btcyks35m4JLSNOs9ymJoNQLjeX', t.token
    assert_equal 144, t.amount
    assert t.on_test_gateway?
    assert_equal Time.parse("2013-07-31 19:46:26 UTC"), t.created_at
    assert_equal Time.parse("2013-07-31 19:46:32 UTC"), t.updated_at
    assert_equal 'USD', t.currency_code
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal '187A', t.order_id
    assert_equal '', t.ip
    assert_equal '4 Shardblades', t.description
    assert_equal '', t.merchant_name_descriptor
    assert_equal '', t.merchant_location_descriptor
    assert_equal 'YOaCn5a9xRaBTGgmGAWbkgWUuqv', t.gateway_token
    assert_equal '8xXXIPGXTaPXysDA5OUpgnjTEjK', t.payment_method.token
    assert_equal "44", t.gateway_transaction_id
    assert_equal "Purchase", t.transaction_type

    assert t.response.success
    assert_equal 'Successful purchase', t.response.message
    assert_equal '22', t.response.avs_code
    assert_equal 'I will be back', t.response.avs_message
    assert_equal '31', t.response.cvv_code
    assert_equal 'Rutabaga', t.response.cvv_message
    assert !t.response.pending
    assert !t.response.fraud_review
    assert_equal '899', t.response.error_code
    assert_equal 'The eagle lives!', t.response.error_detail
    assert !t.response.cancelled
    assert_equal Time.parse('2013-07-31T19:46:26Z'), t.response.created_at
    assert_equal Time.parse('2013-07-31T19:46:27Z'), t.response.updated_at

    assert_equal '', t.shipping_address.name
    assert_equal '', t.shipping_address.address1
    assert_equal '', t.shipping_address.address2
    assert_equal '', t.shipping_address.city
    assert_equal '', t.shipping_address.state
    assert_equal '', t.shipping_address.zip
    assert_equal '', t.shipping_address.country
    assert_equal '', t.shipping_address.phone_number
  end

  def test_failed_purchase
    t = purchase_using(failed_purchase_response)

    assert_kind_of(Spreedly::Purchase, t)
    assert_equal 'RxkxK78ZlvDiXRQRnyuJM5ee0Ww', t.token
    assert_equal 5148, t.amount
    assert !t.succeeded?
    assert_equal 'gateway_processing_failed', t.state

    assert_equal 'The eagle is dead Jim.', t.response.error_detail
  end

  def test_successful_purchase_with_shipping_address_override
    t = purchase_using(successful_purchase_with_shipping_address_override_response)

    assert_equal 'John Doe', t.shipping_address.name
    assert_equal '123 Main St.', t.shipping_address.address1
    assert_equal 'Unit 1', t.shipping_address.address2
    assert_equal 'Acme', t.shipping_address.city
    assert_equal 'Corp', t.shipping_address.state
    assert_equal '45678', t.shipping_address.zip
    assert_equal 'USA', t.shipping_address.country
    assert_equal '123-456-7890', t.shipping_address.phone_number
  end

  def test_request_body_params
    body = get_request_body(successful_purchase_response) do
      @environment.purchase_on_gateway("TheGatewayToken", "TheCardToken", 2001, all_possible_options)
    end

    transaction = body.xpath('./transaction')
    assert_xpaths_in transaction,
      [ './amount', '2001' ],
      [ './currency_code', 'EUR' ],
      [ './payment_method_token', 'TheCardToken' ],
      [ './order_id', '8675' ],
      [ './description', 'SuperDuper' ],
      [ './ip', '183.128.100.103' ],
      [ './merchant_name_descriptor', 'Real Stuff' ],
      [ './merchant_location_descriptor', 'Raleigh' ],
      [ './retain_on_success', 'true' ]
  end


  private
  def purchase_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.purchase_on_gateway("IgnoredGatewayTokenSinceResponseIsStubbed", "IgnoredPaymentMethodTokenSinceResponseIsStubbed", 5921)
  end

  def all_possible_options
    {
      currency_code: "EUR",
      order_id: "8675",
      description: "SuperDuper",
      ip: "183.128.100.103",
      merchant_name_descriptor: "Real Stuff",
      merchant_location_descriptor: "Raleigh",
      retain_on_success: true
    }
  end

end
