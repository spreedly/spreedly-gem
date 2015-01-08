require 'test_helper'
require 'unit/response_stubs/gateway_options_stubs'

class GatewayOptionsTest < Test::Unit::TestCase

  include GatewayOptionsStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_gateway_options
    @environment.stubs(:raw_ssl_request).returns(successful_gateway_options_response)
    list = @environment.gateway_options

    assert_kind_of(Array, list)
    assert_equal 2, list.size

    assert_equal 'PayPal', list.first.name
    assert_equal ["US", "GB", "CA"], list.first.supported_countries
    assert_equal ["credit_card", "paypal"], list.first.payment_methods
    assert_equal "paypal", list.first.gateway_type
    assert_equal "http://paypal.com/", list.first.homepage
    assert_kind_of Spreedly::GatewayClass, list.first
    assert_kind_of Spreedly::GatewayClass, list.last
  end

  def test_successful_gateway_auth_modes
    @environment.stubs(:raw_ssl_request).returns(successful_gateway_options_response)
    list = @environment.gateway_options.first.auth_modes

    assert_kind_of Array, list
    assert_equal 3, list.size

    assert_equal "signature", list.first.auth_mode_type
    assert_equal "Signature", list.first.name
    assert_kind_of Array, list.first.credentials
    assert_equal 3, list.first.credentials.size
  end

  def test_successful_gateway_auth_mode_credentials
    @environment.stubs(:raw_ssl_request).returns(successful_gateway_options_response)
    list = @environment.gateway_options.first.auth_modes.first.credentials

    assert_kind_of Array, list
    assert_equal 3, list.size

    assert_equal "login", list.first.name
    assert_equal "Login", list.first.label
    assert_equal true, list.first.safe
  end

  def test_characteristics
    @environment.stubs(:raw_ssl_request).returns(successful_gateway_options_response)
    gateway_class = @environment.gateway_options.first

    [ :supports_purchase,
      :supports_authorize,
      :supports_capture,
      :supports_credit,
      :supports_general_credit,
      :supports_void,
      :supports_reference_purchase,
      :supports_purchase_via_preauthorization,
      :supports_offsite_purchase,
      :supports_offsite_authorize,
      :supports_3dsecure_purchase,
      :supports_3dsecure_authorize,
      :supports_store,
      :supports_fraud_review
    ].each do |c|
      assert gateway_class.send("#{c}?")
    end

    assert !gateway_class.send(:supports_remove?)
  end
end
