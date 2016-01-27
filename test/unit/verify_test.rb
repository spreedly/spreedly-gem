require 'test_helper'
require 'unit/response_stubs/verification_stubs'

class VerifyTest < Test::Unit::TestCase

  include VerificationStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_verify
    t = verify_using(successful_verify_response)

    assert_kind_of(Spreedly::Verification, t)
    assert_equal 'CSCoubzCMgrD4FAv1CRmucVTxTQ', t.token
    assert t.on_test_gateway?
    assert_equal Time.parse("2014-07-03T19:43:19Z"), t.created_at
    assert_equal Time.parse("2014-07-03T19:43:20Z"), t.updated_at
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal '99a1', t.order_id
    assert_equal '182.129.106.102', t.ip
    assert_equal 'LotsOCoffee', t.description
    assert_equal 'My Writeoff Inc.', t.merchant_name_descriptor
    assert_equal 'Tax Free Zone', t.merchant_location_descriptor
    assert_equal 'LoxFMxQJD5E1ksAwFWykUamaCKE', t.gateway_token
    assert_equal "49", t.gateway_transaction_id
    assert_equal 'Verification', t.transaction_type

    assert_equal '98626DYInHb4K86dp6GrocnZOW6', t.payment_method.token
    assert_equal 'Aybara', t.payment_method.last_name

    assert t.response.success
    assert_equal 'Successful verify', t.response.message
  end

  def test_failed_authorize
    t = verify_using(failed_verify_response)

    assert_kind_of(Spreedly::Verification, t)
    assert_equal 'LoXHEUXYFDCxGLGcG94JVh9FKmE', t.token
    assert !t.succeeded?
    assert_equal 'gateway_processing_failed', t.state
    assert_equal 'What up with that?', t.response.error_detail
  end

  def test_request_body_params
    body = get_request_body(successful_verify_response) do
      @environment.verify_on_gateway("TheGatewayToken", "TheCardToken", all_possible_options)
    end

    transaction = body.xpath('./transaction')
    assert_xpaths_in transaction,
      [ './payment_method_token', 'TheCardToken' ],
      [ './order_id', '8669' ],
      [ './description', 'Gold Farmin' ],
      [ './ip', '183.128.100.102' ],
      [ './merchant_name_descriptor', 'TRain' ],
      [ './merchant_location_descriptor', 'British Colombia' ],
      [ './retain_on_success', 'true' ]
  end


  private
  def verify_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.verify_on_gateway("IgnoredGatewayTokenSinceResponseIsStubbed", "IgnoredPaymentMethodTokenSinceResponseIsStubbed")
  end

  def all_possible_options
    {
      order_id: "8669",
      description: "Gold Farmin",
      ip: "183.128.100.102",
      merchant_name_descriptor: "TRain",
      merchant_location_descriptor: "British Colombia",
      retain_on_success: true
    }
  end

end
