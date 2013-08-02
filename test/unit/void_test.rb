require 'test_helper'
require 'unit/response_stubs/void_stubs'

class VoidTest < Test::Unit::TestCase

  include VoidStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_void
    t = void_using(successful_void_response)

    assert_kind_of(Spreedly::Void, t)
    assert_equal 'YutwWIoICGiFvSWUQbb9LTyjfnF', t.token
    assert_equal Time.parse('2013-08-01T19:05:53Z'), t.created_at
    assert_equal Time.parse('2013-08-01T19:05:53Z'), t.updated_at
    assert_equal true, t.on_test_gateway
    assert_equal true, t.on_test_gateway?
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal '49J', t.order_id
    assert_equal '102.122.012.111', t.ip
    assert_equal 'DopeCorp', t.merchant_name_descriptor
    assert_equal '', t.merchant_location_descriptor
    assert_equal 'EuXlDMZEMZfrHSvE9tkRzaW8j0z', t.gateway_token
    assert_equal 'CjedAratpuiT3CMmln4t3oZFvOS', t.reference_token

    assert_equal true, t.response.success
    assert_equal 'Successful void', t.response.message
    assert_equal '', t.response.avs_code
    assert_equal '', t.response.avs_message
    assert_equal '', t.response.cvv_code
    assert_equal '', t.response.cvv_message
    assert_equal false, t.response.pending
    assert_equal '', t.response.error_code
    assert_equal '', t.response.error_detail
    assert_equal false, t.response.cancelled
    assert_equal Time.parse('2013-08-01T19:05:53Z'), t.response.created_at
    assert_equal Time.parse('2013-08-01T19:05:53Z'), t.response.updated_at
  end

  def test_failed_void
    t = void_using(failed_void_response)

    assert_kind_of(Spreedly::Void, t)
    assert_equal '39gMhrti9KGiuLXa9suYL3kn3st', t.token
    assert !t.succeeded?
    assert_equal 'gateway_processing_failed', t.state
    assert_equal 'Transaction id is invalid.', t.message
    assert_equal '10609', t.response.error_code
    assert_equal false, t.on_test_gateway
  end

  private
  def void_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.void_transaction("IgnoredTransactionTokenSinceResponseIsStubbed")
  end

end

