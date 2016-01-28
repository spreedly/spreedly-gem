require 'test_helper'
require 'unit/response_stubs/capture_stubs'

class CaptureTest < Test::Unit::TestCase

  include CaptureStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_capture
    t = capture_using(successful_capture_response)

    assert_kind_of(Spreedly::Capture, t)
    assert_equal 'T41uDjYsxGybSsp7RHuRTohMjg2', t.token
    assert_equal 801, t.amount
    assert t.on_test_gateway?
    assert_equal Time.parse("2013-08-05 13:58:50 UTC"), t.created_at
    assert_equal Time.parse("2013-08-05 13:58:50 UTC"), t.updated_at
    assert_equal 'USD', t.currency_code
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal '99a1', t.order_id
    assert_equal '182.129.106.102', t.ip
    assert_equal 'LotsOCoffee', t.description
    assert_equal 'My Writeoff Inc.', t.merchant_name_descriptor
    assert_equal 'Tax Free Zone', t.merchant_location_descriptor
    assert_equal 'SoPblCOGDwaRyym68XGWeRiCy1C', t.gateway_token
    assert_equal 'PH6U2tyFWtDSVp88bNW2nnGy5rk', t.reference_token
    assert_equal 'Capture', t.transaction_type
    assert_equal "credit", t.gateway_specific_response_fields[:stripe][:card_funding]

    assert t.response.success
    assert_equal 'Successful capture', t.response.message
  end

  def test_failed_capture
    t = capture_using(failed_capture_response)

    assert_kind_of(Spreedly::Capture, t)
    assert_equal 'Z4XAoSG11rd4zo9p9sRxpstKufX', t.token
    assert_equal 44, t.amount
    assert !t.succeeded?
    assert_equal 'gateway_processing_failed', t.state

    assert_equal 'The eagle has hit the window.', t.response.error_detail
  end

  def test_empty_request_body_params
    body = get_request_body(successful_capture_response) do
      @environment.capture_transaction("TheAuthorizationToken")
    end

    assert_nil body.root
  end

  def test_request_body_params
    body = get_request_body(successful_capture_response) do
      @environment.capture_transaction("TheAuthorizationToken", all_possible_options)
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
  def capture_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.capture_transaction("IgnoredTokenSinceResponseIsStubbed")
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
