require 'test_helper'
require 'unit/response_stubs/offsite_purchase_stubs'

class OffsitePurchaseTest < Test::Unit::TestCase

  include OffsitePurchaseStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_pending_offsite_purchase
    t = offsite_purchase_using(pending_offsite_purchase_response)

    assert_kind_of(Spreedly::OffsitePurchase, t)
    assert_equal 'offsite-purchase-token', t.token
    assert_equal 100, t.amount
    assert t.on_test_gateway?
    assert_equal Time.parse("2015-03-13 02:36:51 UTC"), t.created_at
    assert_equal Time.parse("2015-03-13 02:36:51 UTC"), t.updated_at
    assert_equal 'USD', t.currency_code
    assert !t.succeeded?
    assert_equal 'pending', t.state
    assert_equal '123', t.order_id
    assert_equal '127.0.0.1', t.ip
    assert_equal '3 Widgets', t.description
    assert_equal '', t.merchant_name_descriptor
    assert_equal '', t.merchant_location_descriptor
    assert_equal 'offsite-gateway-token', t.gateway_token
    assert_equal 'offsite-payment-method-token', t.payment_method.token

    assert t.response.success
    assert_equal 'Setup response message', t.response.message
    assert_equal '899', t.response.error_code
    assert_equal Time.parse('2015-03-13 02:36:51 UTC'), t.response.created_at
    assert_equal Time.parse('2015-03-13 02:36:51 UTC'), t.response.updated_at
    assert_equal 'https://checkout.com', t.response.checkout_url
  end

  def test_failed_purchase
    t = offsite_purchase_using(failed_offsite_purchase_response)

    assert_kind_of(Spreedly::OffsitePurchase, t)
    assert_equal 'offsite-purchase-token', t.token
    assert_equal 100, t.amount
    assert !t.succeeded?
    assert_equal 'gateway_processing_failed', t.state
  end

  def test_request_body_params
    body = get_request_body(pending_offsite_purchase_response) do
      @environment.purchase_on_gateway("gateway-token", "payment-method-token", 100, all_possible_options)
    end

    transaction = body.xpath('./transaction')
    assert_xpaths_in transaction,
      [ './amount', '100' ],
      [ './currency_code', 'USD' ],
      [ './payment_method_token', 'payment-method-token' ],
      [ './order_id', '123' ],
      [ './description', '3 Widgets' ],
      [ './ip', '127.0.0.1' ],
      [ './merchant_name_descriptor', '' ],
      [ './merchant_location_descriptor', '' ]
  end


  private
  def offsite_purchase_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.purchase_on_gateway("IgnoredGatewayTokenSinceResponseIsStubbed", "IgnoredPaymentMethodTokenSinceResponseIsStubbed", 5921)
  end

  def all_possible_options
    {
      currency_code: "USD",
      order_id: "123",
      description: "3 Widgets",
      ip: "127.0.0.1",
      merchant_name_descriptor: "",
      merchant_location_descriptor: ""
    }
  end

end
