require 'test_helper'

class AddGatewayTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_add_test_gateway
    @environment.stubs(:raw_ssl_request).returns(successful_add_test_gateway_response)

    gateway = @environment.add_gateway(:test)
    assert_equal "4dFb93AiRDEJ18MS9xDGMyu22uO", gateway.token
    assert_equal "test", gateway.gateway_type
    assert_equal "retained", gateway.state
    assert_equal "Test", gateway.name
  end

  # TODO
  # Tests coming for characteristics, payment_methods, and gateway_specific_fields.
  # We'll also soon handle adding other types of gateways.

  private
  def successful_add_test_gateway_response
    StubResponse.succeeded <<-XML
      <gateway>
        <token>4dFb93AiRDEJ18MS9xDGMyu22uO</token>
        <gateway_type>test</gateway_type>
        <name>Test</name>
        <characteristics>
          <supports_purchase type="boolean">true</supports_purchase>
          <supports_authorize type="boolean">true</supports_authorize>
          <supports_capture type="boolean">true</supports_capture>
          <supports_credit type="boolean">true</supports_credit>
          <supports_void type="boolean">true</supports_void>
          <supports_reference_purchase type="boolean">true</supports_reference_purchase>
          <supports_purchase_via_preauthorization type="boolean">true</supports_purchase_via_preauthorization>
          <supports_offsite_purchase type="boolean">true</supports_offsite_purchase>
          <supports_offsite_authorize type="boolean">true</supports_offsite_authorize>
          <supports_3dsecure_purchase type="boolean">true</supports_3dsecure_purchase>
          <supports_3dsecure_authorize type="boolean">true</supports_3dsecure_authorize>
          <supports_store type="boolean">true</supports_store>
          <supports_remove type="boolean">true</supports_remove>
        </characteristics>
        <state>retained</state>
        <payment_methods>
          <payment_method>credit_card</payment_method>
          <payment_method>sprel</payment_method>
          <payment_method>third_party_token</payment_method>
          <payment_method>bank_account</payment_method>
        </payment_methods>
        <gateway_specific_fields/>
        <redacted type="boolean">false</redacted>
        <created_at type="datetime">2013-07-31T17:17:36Z</created_at>
        <updated_at type="datetime">2013-07-31T17:17:36Z</updated_at>
      </gateway>
    XML
  end

end
