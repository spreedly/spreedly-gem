module RedactGatewayStubs

  def successful_redact_gateway_response
    StubResponse.succeeded <<-XML
      <transaction>
        <token>NXKt1iNkIJhzF5QCDt1qSsuFbcN</token>
        <created_at type="datetime">2013-08-19T17:16:07Z</created_at>
        <updated_at type="datetime">2013-08-19T17:16:07Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <transaction_type>RedactGateway</transaction_type>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway>
          <token>8zy49qcEUigjYbpPKCjlhDzUqJ</token>
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
            <supports_disburse type="boolean">true</supports_disburse>
          </characteristics>
          <state>redacted</state>
          <payment_methods>
            <payment_method>credit_card</payment_method>
            <payment_method>sprel</payment_method>
            <payment_method>third_party_token</payment_method>
            <payment_method>bank_account</payment_method>
          </payment_methods>
          <gateway_specific_fields/>
          <redacted type="boolean">true</redacted>
          <created_at type="datetime">2013-08-19T17:16:06Z</created_at>
          <updated_at type="datetime">2013-08-19T17:16:07Z</updated_at>
        </gateway>
      </transaction>
    XML
  end

end
