module GeneralCreditStubs

  def successful_general_credit_response
    StubResponse.succeeded <<-XML
      <transaction>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="dateTime">2015-01-08T21:04:21Z</created_at>
        <updated_at type="dateTime">2015-01-08T21:04:21Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <state>succeeded</state>
        <token>WXVcJaRT5lJYNRGi1AGHkIUYc8Y</token>
        <transaction_type>GeneralCredit</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <description nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <gateway_transaction_id>62</gateway_transaction_id>
        <amount type="integer">2500</amount>
        <currency_code>USD</currency_code>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_token>8XJtbE1p4NTZ6fFqwwn0GrkjEmW</gateway_token>
        <response>
          <success type="boolean">true</success>
          <message>Successful general_credit</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <result_unknown type="boolean">false</result_unknown>
          <error_code></error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <fraud_review nil="true"/>
          <created_at type="dateTime">2015-01-08T21:04:21Z</created_at>
          <updated_at type="dateTime">2015-01-08T21:04:21Z</updated_at>
        </response>
        <api_urls>
        </api_urls>
        <payment_method>
          <token>LkCjAT9nvYrP90pc5pc1MbcrYTD</token>
          <created_at type="dateTime">2014-11-10T18:26:19Z</created_at>
          <updated_at type="dateTime">2015-01-08T21:04:21Z</updated_at>
          <email nil="true"/>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <test type="boolean">true</test>
          <last_four_digits>1111</last_four_digits>
          <first_six_digits>411111</first_six_digits>
          <card_type>visa</card_type>
          <first_name>Brando</first_name>
          <last_name>Hamill</last_name>
          <month type="integer">4</month>
          <year type="integer">2020</year>
          <address1 nil="true"/>
          <address2 nil="true"/>
          <city nil="true"/>
          <state nil="true"/>
          <zip nil="true"/>
          <country nil="true"/>
          <phone_number nil="true"/>
          <full_name>Brando Hamill</full_name>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <shipping_address1 nil="true"/>
          <shipping_address2 nil="true"/>
          <shipping_city nil="true"/>
          <shipping_state nil="true"/>
          <shipping_zip nil="true"/>
          <shipping_country nil="true"/>
          <shipping_phone_number nil="true"/>
          <payment_method_type>credit_card</payment_method_type>
          <errors>
          </errors>
          <verification_value></verification_value>
          <number>XXXX-XXXX-XXXX-1111</number>
        </payment_method>
      </transaction>
    XML
  end
end
