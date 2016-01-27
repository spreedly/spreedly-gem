require 'test_helper'
require 'unit/response_stubs/refund_stubs'

class RefundTest < Test::Unit::TestCase

  include RefundStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_refund
    t = refund_using(successful_refund_response)

    assert_kind_of(Spreedly::Refund, t)
    assert_equal 'JyQegcYcIFA2jUg22OYTGiUyXTR', t.token
    assert_equal 944, t.amount
    assert t.on_test_gateway?
    assert_equal Time.parse("2013-08-05 16:37:13 UTC"), t.created_at
    assert_equal Time.parse("2013-08-05 16:37:13 UTC"), t.updated_at
    assert_equal 'USD', t.currency_code
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal '99a1', t.order_id
    assert_equal '182.129.106.102', t.ip
    assert_equal 'LotsOCoffee', t.description
    assert_equal 'My Writeoff Inc.', t.merchant_name_descriptor
    assert_equal 'Tax Free Zone', t.merchant_location_descriptor
    assert_equal 'XYI0V2l4KC1cAm6Y3c2kG5loJaA', t.gateway_token
    assert_equal 'RkIAltzr49eXuWc7ajBjLLeKZt8', t.reference_token
    assert_equal 'Credit', t.transaction_type

    assert t.response.success
    assert_equal 'Successful credit', t.response.message
  end

  def test_failed_refund
    t = refund_using(failed_refund_response)

    assert_kind_of(Spreedly::Refund, t)
    assert_equal 'UWB0L2Q2hwX1qy3Z8UdHd426icC', t.token
    assert_equal 44, t.amount
    assert !t.succeeded?
    assert_equal 'gateway_processing_failed', t.state

    assert_equal 'The eagle is actually a dead duck.', t.response.error_detail
  end

  def test_empty_request_body_params
    body = get_request_body(successful_refund_response) do
      @environment.refund_transaction("TheTransactionToken")
    end

    assert_nil body.root
  end

  def test_request_body_params
    body = get_request_body(successful_refund_response) do
      @environment.refund_transaction("TheTransactionToken", all_possible_options)
    end

    transaction = body.xpath('./transaction')
    assert_xpaths_in transaction,
      [ './amount', '29' ],
      [ './currency_code', 'CAD' ],
      [ './order_id', '8668' ],
      [ './description', 'Gold Farmin' ],
      [ './ip', '183.128.100.102' ],
      [ './merchant_name_descriptor', 'TRain' ],
      [ './merchant_location_descriptor', 'British Colombia' ]
  end


  private
  def refund_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.refund_transaction("IgnoredTokenSinceResponseIsStubbed")
  end

  def all_possible_options
    {
      amount: 29,
      currency_code: "CAD",
      order_id: "8668",
      description: "Gold Farmin",
      ip: "183.128.100.102",
      merchant_name_descriptor: "TRain",
      merchant_location_descriptor: "British Colombia"
    }
  end

end
