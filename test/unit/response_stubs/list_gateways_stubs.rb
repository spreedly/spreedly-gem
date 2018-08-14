module ListGatewaysStubs

  def successful_list_gateways_response
    StubResponse.succeeded <<-XML
      <gateways>
        <gateway>
          <token>OJUFe5ZR6pFfL4i4ZGVmvGWkZUY</token>
          <gateway_type>test</gateway_type>
          <name>Spreedly Test</name>
          <characteristics>
            <supports_purchase type="boolean">true</supports_purchase>
            <supports_authorize type="boolean">true</supports_authorize>
            <supports_capture type="boolean">true</supports_capture>
            <supports_credit type="boolean">true</supports_credit>
            <supports_general_credit type="boolean">true</supports_general_credit>
            <supports_void type="boolean">true</supports_void>
            <supports_reference_purchase type="boolean">true</supports_reference_purchase>
            <supports_purchase_via_preauthorization type="boolean">true</supports_purchase_via_preauthorization>
            <supports_offsite_purchase type="boolean">true</supports_offsite_purchase>
            <supports_offsite_authorize type="boolean">true</supports_offsite_authorize>
            <supports_3dsecure_purchase type="boolean">true</supports_3dsecure_purchase>
            <supports_3dsecure_authorize type="boolean">true</supports_3dsecure_authorize>
            <supports_store type="boolean">true</supports_store>
            <supports_remove type="boolean">true</supports_remove>
            <supports_fraud_review type="boolean">true</supports_fraud_review>
          </characteristics>
          <credentials>
          </credentials>
          <gateway_specific_fields/>
          <payment_methods>
            <payment_method>credit_card</payment_method>
            <payment_method>sprel</payment_method>
            <payment_method>third_party_token</payment_method>
            <payment_method>bank_account</payment_method>
          </payment_methods>
          <state>retained</state>
          <redacted type="boolean">false</redacted>
          <created_at type="datetime">2013-08-23T19:36:00Z</created_at>
          <updated_at type="datetime">2013-08-23T19:36:00Z</updated_at>
        </gateway>
        <gateway>
          <token>52wqOssuKZSXEYde30AGTG6xl8v</token>
          <gateway_type>test</gateway_type>
          <name>Spreedly Test</name>
          <characteristics>
            <supports_purchase type="boolean">true</supports_purchase>
            <supports_authorize type="boolean">true</supports_authorize>
            <supports_capture type="boolean">true</supports_capture>
            <supports_credit type="boolean">true</supports_credit>
            <supports_general_credit type="boolean">true</supports_general_credit>
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
          <credentials>
          </credentials>
          <gateway_specific_fields/>
          <payment_methods>
            <payment_method>credit_card</payment_method>
            <payment_method>sprel</payment_method>
            <payment_method>third_party_token</payment_method>
            <payment_method>bank_account</payment_method>
          </payment_methods>
          <state>retained</state>
          <redacted type="boolean">false</redacted>
          <created_at type="datetime">2013-08-23T19:36:00Z</created_at>
          <updated_at type="datetime">2013-08-23T19:36:00Z</updated_at>
        </gateway>
      </gateways>
    XML
  end
end
