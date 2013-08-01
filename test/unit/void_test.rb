require 'test_helper'

class VoidTest < Test::Unit::TestCase

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
    assert_equal true, t.succeeded
    assert_equal true, t.succeeded?
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
    assert_equal false, t.succeeded?
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

  def successful_void_response
    StubResponse.succeeded <<-XML
      <transaction>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-08-01T19:05:53Z</created_at>
        <updated_at type="datetime">2013-08-01T19:05:53Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <token>YutwWIoICGiFvSWUQbb9LTyjfnF</token>
        <state>succeeded</state>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>Void</transaction_type>
        <order_id>49J</order_id>
        <ip>102.122.012.111</ip>
        <description nil="true"/>
        <merchant_name_descriptor>DopeCorp</merchant_name_descriptor>
        <merchant_location_descriptor nil="true"/>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_token>EuXlDMZEMZfrHSvE9tkRzaW8j0z</gateway_token>
        <reference_token>CjedAratpuiT3CMmln4t3oZFvOS</reference_token>
        <response>
          <success type="boolean">true</success>
          <message>Successful void</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <error_code></error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-01T19:05:53Z</created_at>
          <updated_at type="datetime">2013-08-01T19:05:53Z</updated_at>
        </response>
      </transaction>
    XML
  end

  def failed_void_response
    StubResponse.failed <<-XML
      <transaction>
        <on_test_gateway type="boolean">false</on_test_gateway>
        <created_at type="datetime">2013-08-01T19:48:41Z</created_at>
        <updated_at type="datetime">2013-08-01T19:48:42Z</updated_at>
        <succeeded type="boolean">false</succeeded>
        <token>39gMhrti9KGiuLXa9suYL3kn3st</token>
        <state>gateway_processing_failed</state>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>Void</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <description nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <message>Transaction id is invalid.</message>
        <gateway_token>2AocQ8IUvnrr6J0xPGW7QbrMX6E</gateway_token>
        <reference_token>KNFrnpBYd9kFohOBZVL6GEmSGJB</reference_token>
        <response>
          <success type="boolean">false</success>
          <message>Transaction id is invalid.</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <error_code>10609</error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-01T19:48:42Z</created_at>
          <updated_at type="datetime">2013-08-01T19:48:42Z</updated_at>
        </response>
      </transaction>
    XML
  end
end

