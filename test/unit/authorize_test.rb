require 'test_helper'
require 'unit/response_stubs/authorization_stubs'

class AuthorizeTest < Test::Unit::TestCase

  include AuthorizationStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_authorize
    t = authorize_using(successful_authorize_response)

    assert_kind_of(Spreedly::Authorization, t)
    assert_equal 'NjsT1PRC5pHyz89H01bj1t2AVNo', t.token
    assert_equal 345, t.amount
    assert t.on_test_gateway?
    assert_equal Time.parse("2013-08-05 13:11:28 UTC"), t.created_at
    assert_equal Time.parse("2013-08-05 13:11:28 UTC"), t.updated_at
    assert_equal 'USD', t.currency_code
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal '99a1', t.order_id
    assert_equal '182.129.106.102', t.ip
    assert_equal 'LotsOCoffee', t.description
    assert_equal 'My Writeoff Inc.', t.merchant_name_descriptor
    assert_equal 'Tax Free Zone', t.merchant_location_descriptor
    assert_equal 'YjWxOjbpeieXsZFdAsbhM2DFgLe', t.gateway_token
    assert_equal "44", t.gateway_transaction_id
    assert_equal "Authorization", t.transaction_type
    assert_equal "TheName", t.gateway_specific_fields[:litle][:descriptor_name]
    assert_equal "33411441", t.gateway_specific_fields[:litle][:descriptor_phone]
    assert_equal "844", t.gateway_specific_fields[:stripe][:application_fee]

    assert_equal 'Nh2Vw0kAoSQvcJDpK52q4dZlrVJ', t.payment_method.token
    assert_equal 'Forthrast', t.payment_method.last_name

    assert t.response.success
    assert_equal 'Successful authorize', t.response.message
  end

  def test_failed_authorize
    t = authorize_using(failed_authorize_response)

    assert_kind_of(Spreedly::Authorization, t)
    assert_equal 'PHuCG2kfgyr92CgKuqlblFbgZJP', t.token
    assert_equal 2391, t.amount
    assert !t.succeeded?
    assert_equal 'gateway_processing_failed', t.state

    assert_equal 'The eagle may have perished.', t.response.error_detail
  end

  def test_request_body_params
    body = get_request_body(successful_authorize_response) do
      @environment.authorize_on_gateway("TheGatewayToken", "TheCardToken", 2001, all_possible_options)
    end

    transaction = body.xpath('./transaction')
    assert_xpaths_in transaction,
      [ './amount', '2001' ],
      [ './currency_code', 'CAD' ],
      [ './payment_method_token', 'TheCardToken' ],
      [ './order_id', '8669' ],
      [ './description', 'Gold Farmin' ],
      [ './ip', '183.128.100.102' ],
      [ './merchant_name_descriptor', 'TRain' ],
      [ './merchant_location_descriptor', 'British Colombia' ],
      [ './gateway_specific_fields/braintree/customer_id', '1143' ],
      [ './retain_on_success', 'true' ]
  end


  private
  def authorize_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.authorize_on_gateway("IgnoredGatewayTokenSinceResponseIsStubbed", "IgnoredPaymentMethodTokenSinceResponseIsStubbed", 5921)
  end

  def all_possible_options
    {
      currency_code: "CAD",
      order_id: "8669",
      description: "Gold Farmin",
      ip: "183.128.100.102",
      merchant_name_descriptor: "TRain",
      merchant_location_descriptor: "British Colombia",
      gateway_specific_fields: {
        braintree: { customer_id: "1143" }
      },
      retain_on_success: true
    }
  end

end
