require 'test_helper'
require 'unit/response_stubs/general_credit_stubs'

class GeneralCreditTest < Test::Unit::TestCase

  include GeneralCreditStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_general_credit
    t = general_credit_using(successful_general_credit_response)

    assert_kind_of(Spreedly::GeneralCredit, t)
    assert_equal 'WXVcJaRT5lJYNRGi1AGHkIUYc8Y', t.token
    assert_equal 2500, t.amount
    assert t.on_test_gateway?
    assert_equal Time.parse("2015-01-08 21:04:21 UTC"), t.created_at
    assert_equal Time.parse("2015-01-08 21:04:21 UTC"), t.updated_at
    assert_equal 'USD', t.currency_code
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal '', t.order_id
    assert_equal '', t.ip
    assert_equal '', t.description
    assert_equal '', t.merchant_name_descriptor
    assert_equal '', t.merchant_location_descriptor
    assert_equal '8XJtbE1p4NTZ6fFqwwn0GrkjEmW', t.gateway_token
    assert_equal "62", t.gateway_transaction_id

    assert t.response.success
    assert_equal 'Successful general_credit', t.response.message
    assert_equal '', t.response.avs_code
    assert_equal '', t.response.avs_message
    assert_equal '', t.response.cvv_code
    assert_equal '', t.response.cvv_message
    assert !t.response.pending
    assert !t.response.fraud_review
    assert_equal '', t.response.error_code
    assert_equal '', t.response.error_detail
    assert !t.response.cancelled
    assert_equal Time.parse('2015-01-08 21:04:21 UTC'), t.response.created_at
    assert_equal Time.parse('2015-01-08 21:04:21 UTC'), t.response.updated_at
  end

  def test_request_body_params
    body = get_request_body(successful_general_credit_response) do
      @environment.general_credit_on_gateway("TheGatewayToken", "TheCardToken", 900_900_00, all_possible_options)
    end

    transaction = body.xpath('./transaction')
    assert_xpaths_in transaction,
      [ './amount', '90090000' ],
      [ './currency_code', 'IDR' ],
      [ './payment_method_token', 'TheCardToken' ],
      [ './order_id', '2016' ],
      [ './description', 'Enjoy!' ],
      [ './ip', '183.128.100.111' ],
      [ './merchant_name_descriptor', 'Cthulhu' ],
      [ './merchant_location_descriptor', 'Narnia' ]
  end


  private
  def general_credit_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.general_credit_on_gateway("IgnoredGatewayTokenSinceResponseIsStubbed", "IgnoredPaymentMethodTokenSinceResponseIsStubbed", 1234)
  end

  def all_possible_options
    {
      currency_code: "IDR",
      order_id: "2016",
      description: "Enjoy!",
      ip: "183.128.100.111",
      merchant_name_descriptor: "Cthulhu",
      merchant_location_descriptor: "Narnia"
    }
  end

end
