module FindTransactionStubs

  def successful_get_transaction_response
    StubResponse.succeeded <<-XML
      <transaction>
        <token>2IFzBBh99rwjXKkZ0hkPVLjCBXL</token>
        <created_at type="datetime">2013-08-05T19:32:49Z</created_at>
        <updated_at type="datetime">2013-08-05T19:32:49Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <transaction_type>AddPaymentMethod</transaction_type>
        <retained type="boolean">true</retained>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_transaction_id>47</gateway_transaction_id>
        <payment_method>
          <token>7sqmBrh8zS4Mgei6wOyYskFpghF</token>
          <created_at type="datetime">2013-08-05T19:32:49Z</created_at>
          <updated_at type="datetime">2013-08-05T19:32:49Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
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

  def responseless_transaction_response
    StubResponse.succeeded <<-XML
      <transaction>
        <amount type="integer">899</amount>
        <on_test_gateway type="boolean">false</on_test_gateway>
        <created_at type="datetime">2014-10-15T19:02:49Z</created_at>
        <updated_at type="datetime">2014-10-15T19:02:49Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">false</succeeded>
        <state>failed</state>
        <token>1f41avmBKchYCNam8rMgrRRTppD</token>
        <transaction_type>Purchase</transaction_type>
        <order_id>136</order_id>
        <ip nil="true"/>
        <description>The Description</description>
        <merchant_name_descriptor>Descriptor</merchant_name_descriptor>
        <merchant_location_descriptor>TheUrl</merchant_location_descriptor>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <message key="messages.cannot_use_redacted_gateway">Unable to use a gateway because it's been redacted.</message>
        <gateway_token>223rRq1muGCYQUMVGu2a1qcG9PK</gateway_token>
        <gateway_transaction_id></gateway_transaction_id>
        <payment_method>
          <token>rYswku4CEaenVlBdmGluGM2cJ8q</token>
          <created_at type="datetime">2013-10-11T20:15:25Z</created_at>
          <updated_at type="datetime">2013-10-11T20:15:25Z</updated_at>
          <email>email@example.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <last_four_digits>2111</last_four_digits>
          <card_type>visa</card_type>
          <first_name>Jonathan</first_name>
          <last_name>Phaedrus</last_name>
          <month type="integer">11</month>
          <year type="integer">2016</year>
          <address1>418 Main Street</address1>
          <address2 nil="true"/>
          <city>Chicago</city>
          <state>IL</state>
          <zip>10657</zip>
          <country>United States</country>
          <phone_number nil="true"/>
          <full_name>Jonathan Phaedrus</full_name>
          <payment_method_type>credit_card</payment_method_type>
          <errors>
          </errors>
          <verification_value></verification_value>
          <number>XXXX-XXXX-XXXX-2111</number>
        </payment_method>
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

end
