module RedactPaymentMethodStubs

  def successful_redact_payment_method_response
    StubResponse.succeeded <<-XML
      <transaction>
        <on_test_gateway type="boolean">false</on_test_gateway>
        <created_at type="datetime">2013-08-05T17:43:41Z</created_at>
        <updated_at type="datetime">2013-08-05T17:43:41Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <token>2BSe5T6FHpypph3ensF7m3Nb3qk</token>
        <state>succeeded</state>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>RedactPaymentMethod</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <payment_method>
          <token>RvsxKgbAZBmiZHEPhhTcOQzJeC2</token>
          <created_at type="datetime">2013-08-05T17:43:41Z</created_at>
          <updated_at type="datetime">2013-08-05T17:43:41Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>redacted</storage_state>
          <last_four_digits>4444</last_four_digits>
          <card_type>master</card_type>
          <first_name>Perrin</first_name>
          <last_name>Aybara</last_name>
          <month type="integer">1</month>
          <year type="integer">2019</year>
          <address1 nil="true"/>
          <address2 nil="true"/>
          <city nil="true"/>
          <state nil="true"/>
          <zip nil="true"/>
          <country nil="true"/>
          <phone_number nil="true"/>
          <full_name>Perrin Aybara</full_name>
          <payment_method_type>credit_card</payment_method_type>
          <errors>
          </errors>
          <verification_value></verification_value>
          <number>XXXX-XXXX-XXXX-4444</number>
        </payment_method>
      </transaction>
    XML
  end

end
