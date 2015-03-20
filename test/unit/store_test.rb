require 'test_helper'
require 'unit/response_stubs/store_stubs'

class StoreTest < Test::Unit::TestCase

  include StoreStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_store
    t = store_using(successful_store_response)

    assert_kind_of(Spreedly::Store, t)
    assert_equal '1gOXWjBEiF83cylf5t4WLe4uULI', t.token
    assert_equal Time.parse("2015-03-20 17:32:04 UTC"), t.created_at
    assert_equal Time.parse("2015-03-20 17:32:04 UTC"), t.updated_at
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal 'McNbLlg7Ytmyyuh45PCsyfHas1r', t.payment_method.token
    assert_equal "test_vault:5555555555554444", t.payment_method.third_party_token
    assert_equal 'GQzlYKsJho12S2VswhsY8Q9qCmM', t.basis_payment_method.token

    assert t.response.success
    assert_equal 'Successful store', t.response.message
    assert !t.response.pending
    assert !t.response.fraud_review
    assert !t.response.cancelled
  end

  def test_failed_store
    t = store_using(failed_store_response)

    assert_kind_of(Spreedly::Store, t)
    assert_equal '88PvId4mseKsO09KlkcoilsbfMW', t.token
    assert !t.succeeded?
    assert_equal 'gateway_processing_failed', t.state

    assert_equal 'E0iLmJB1eHtJJXf7rpmk2UimCVi', t.basis_payment_method.token
    assert_equal 'Unable to store card', t.message
  end

  def test_request_body_params
    body = get_request_body(successful_store_response) do
      @environment.store_on_gateway("TheGatewayToken", "TheCardToken")
    end

    transaction = body.xpath('./transaction')
    assert_xpaths_in transaction, [ './payment_method_token', 'TheCardToken' ]
  end


  private
  def store_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.store_on_gateway("IgnoredGatewayTokenSinceResponseIsStubbed", "IgnoredPaymentMethodTokenSinceResponseIsStubbed")
  end

end
