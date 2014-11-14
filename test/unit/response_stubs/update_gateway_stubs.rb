module UpdateGatewayStubs

  def successful_update_gateway_response
    StubResponse.succeeded <<-XML
      <gateway>
        <token>E5P4BwEtgyvoUEMfnZ7KV2vIM8b</token>
        <gateway_type>authorize_net</gateway_type>
        <name>Authorize.Net</name>
        <login>newlogin</login>
        <characteristics>
          <supports_purchase type="boolean">true</supports_purchase>
          <supports_authorize type="boolean">true</supports_authorize>
          <supports_capture type="boolean">true</supports_capture>
          <supports_credit type="boolean">true</supports_credit>
          <supports_general_credit type="boolean">false</supports_general_credit>
          <supports_void type="boolean">true</supports_void>
          <supports_verify type="boolean">true</supports_verify>
          <supports_reference_purchase type="boolean">false</supports_reference_purchase>
          <supports_purchase_via_preauthorization type="boolean">false</supports_purchase_via_preauthorization>
          <supports_offsite_purchase type="boolean">false</supports_offsite_purchase>
          <supports_offsite_authorize type="boolean">false</supports_offsite_authorize>
          <supports_3dsecure_purchase type="boolean">false</supports_3dsecure_purchase>
          <supports_3dsecure_authorize type="boolean">false</supports_3dsecure_authorize>
          <supports_store type="boolean">false</supports_store>
          <supports_remove type="boolean">false</supports_remove>
        </characteristics>
        <credentials>
          <credential>
            <name>login</name>
            <value>newlogin</value>
          </credential>
        </credentials>
        <gateway_specific_fields>
          <gateway_specific_field>customer_id</gateway_specific_field>
        </gateway_specific_fields>
        <payment_methods>
          <payment_method>credit_card</payment_method>
          <payment_method>bank_account</payment_method>
        </payment_methods>
        <state>retained</state>
        <redacted type="boolean">false</redacted>
        <created_at type="dateTime">2014-11-11T01:09:24Z</created_at>
        <updated_at type="dateTime">2014-11-11T01:09:24Z</updated_at>
      </gateway>
      XML
  end
end
