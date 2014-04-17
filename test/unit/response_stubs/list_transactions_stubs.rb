module ListTransactionsStubs

  def successful_list_transactions_response
    StubResponse.succeeded <<-XML
      <transactions>
        <transaction>
          <amount type="integer">444</amount>
          <on_test_gateway type="boolean">true</on_test_gateway>
          <created_at type="datetime">2013-08-06T02:07:24Z</created_at>
          <updated_at type="datetime">2013-08-06T02:07:24Z</updated_at>
          <currency_code>USD</currency_code>
          <succeeded type="boolean">true</succeeded>
          <state>succeeded</state>
          <token>5Zkgibjs6z5R6XENMtZd8A8ajau</token>
          <transaction_type>Authorization</transaction_type>
          <order_id nil="true"/>
          <ip nil="true"/>
          <description nil="true"/>
          <merchant_name_descriptor nil="true"/>
          <merchant_location_descriptor nil="true"/>
          <gateway_specific_fields nil="true"/>
          <gateway_specific_response_fields nil="true"/>
          <message key="messages.transaction_succeeded">Succeeded!</message>
          <gateway_token>TpjI3MSmLOSfqpFKP2poZRKc6Ru</gateway_token>
          <gateway_transaction_id>44</gateway_transaction_id>
          <response>
            <success type="boolean">true</success>
            <message>Successful authorize</message>
            <avs_code nil="true"/>
            <avs_message nil="true"/>
            <cvv_code nil="true"/>
            <cvv_message nil="true"/>
            <pending type="boolean">false</pending>
            <error_code></error_code>
            <error_detail nil="true"/>
            <cancelled type="boolean">false</cancelled>
            <created_at type="datetime">2013-08-06T02:07:24Z</created_at>
            <updated_at type="datetime">2013-08-06T02:07:24Z</updated_at>
          </response>
          <payment_method>
            <token>a7I2aus36aN1kC1XpREkYTMOwcr</token>
            <created_at type="datetime">2013-08-06T02:07:23Z</created_at>
            <updated_at type="datetime">2013-08-06T02:07:24Z</updated_at>
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
          <api_urls>
            <referencing_transaction>https://core.spreedly.com/v1/transactions/IGiNeArFVKD6rfYYW9lUP7e008l.xml</referencing_transaction>
          </api_urls>
        </transaction>
        <transaction>
          <amount type="integer">22</amount>
          <on_test_gateway type="boolean">true</on_test_gateway>
          <created_at type="datetime">2013-08-06T02:07:24Z</created_at>
          <updated_at type="datetime">2013-08-06T02:07:24Z</updated_at>
          <currency_code>USD</currency_code>
          <succeeded type="boolean">true</succeeded>
          <state>succeeded</state>
          <token>IGiNeArFVKD6rfYYW9lUP7e008l</token>
          <transaction_type>Capture</transaction_type>
          <order_id nil="true"/>
          <ip nil="true"/>
          <description nil="true"/>
          <merchant_name_descriptor nil="true"/>
          <merchant_location_descriptor nil="true"/>
          <gateway_specific_fields nil="true"/>
          <gateway_specific_response_fields nil="true"/>
          <message key="messages.transaction_succeeded">Succeeded!</message>
          <gateway_token>TpjI3MSmLOSfqpFKP2poZRKc6Ru</gateway_token>
          <response>
            <success type="boolean">true</success>
            <message>Successful capture</message>
            <avs_code nil="true"/>
            <avs_message nil="true"/>
            <cvv_code nil="true"/>
            <cvv_message nil="true"/>
            <pending type="boolean">false</pending>
            <error_code></error_code>
            <error_detail nil="true"/>
            <cancelled type="boolean">false</cancelled>
            <created_at type="datetime">2013-08-06T02:07:24Z</created_at>
            <updated_at type="datetime">2013-08-06T02:07:24Z</updated_at>
          </response>
          <reference_token>5Zkgibjs6z5R6XENMtZd8A8ajau</reference_token>
          <api_urls>
          </api_urls>
        </transaction>
      </transactions>
    XML
  end
end
