module AuthorizationStubs

  def successful_authorize_response
    StubResponse.succeeded <<-XML
      <transaction>
        <amount type="integer">345</amount>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-08-05T13:11:28Z</created_at>
        <updated_at type="datetime">2013-08-05T13:11:28Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">true</succeeded>
        <state>succeeded</state>
        <token>NjsT1PRC5pHyz89H01bj1t2AVNo</token>
        <transaction_type>Authorization</transaction_type>
        <order_id>99a1</order_id>
        <ip>182.129.106.102</ip>
        <description>LotsOCoffee</description>
        <merchant_name_descriptor>My Writeoff Inc.</merchant_name_descriptor>
        <merchant_location_descriptor>Tax Free Zone</merchant_location_descriptor>
        <gateway_specific_fields>
          <litle>
            <descriptor_name>TheName</descriptor_name>
            <descriptor_phone>33411441</descriptor_blah>
          </litle>
          <stripe>
            <application_fee>844</application_fee>
          </stripe>
        </gateway_specific_fields>
        <gateway_specific_response_fields>
          <stripe>
            <card_funding>credit</card_funding>
          </stripe>
        </gateway_specific_response_fields>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_token>YjWxOjbpeieXsZFdAsbhM2DFgLe</gateway_token>
        <gateway_transaction_id>44</gateway_transaction_id>
        <response>
          <success type="boolean">true</success>
          <message>Successful authorize</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <fraud_review type="boolean">false</fraud_review>
          <error_code></error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-05T13:11:28Z</created_at>
          <updated_at type="datetime">2013-08-05T13:11:28Z</updated_at>
        </response>
        <payment_method>
          <token>Nh2Vw0kAoSQvcJDpK52q4dZlrVJ</token>
          <created_at type="datetime">2013-08-05T13:11:28Z</created_at>
          <updated_at type="datetime">2013-08-05T13:11:28Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <last_four_digits>4444</last_four_digits>
          <first_six_digits>411111</first_six_digits>
          <card_type>master</card_type>
          <first_name>John</first_name>
          <last_name>Forthrast</last_name>
          <month type="integer">1</month>
          <year type="integer">2019</year>
          <address1 nil="true"/>
          <address2 nil="true"/>
          <city nil="true"/>
          <state nil="true"/>
          <zip nil="true"/>
          <country nil="true"/>
          <phone_number nil="true"/>
          <company>Acme</company>
          <full_name>John Forthrast</full_name>
          <payment_method_type>credit_card</payment_method_type>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <errors>
          </errors>
          <verification_value></verification_value>
          <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
          <number>XXXX-XXXX-XXXX-4444</number>
        </payment_method>
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

  def failed_authorize_response
    StubResponse.failed <<-XML
      <transaction>
        <amount type="integer">2391</amount>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-08-05T13:16:00Z</created_at>
        <updated_at type="datetime">2013-08-05T13:16:01Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">false</succeeded>
        <state>gateway_processing_failed</state>
        <token>PHuCG2kfgyr92CgKuqlblFbgZJP</token>
        <transaction_type>Authorization</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <description nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <message>Unable to process the authorize transaction.</message>
        <gateway_token>OJoptVkyEg04N4AxfC6H42IH4HU</gateway_token>
        <gateway_transaction_id nil="true"/>
        <response>
          <success type="boolean">false</success>
          <message>Unable to process the authorize transaction.</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <fraud_review type="boolean">false</fraud_review>
          <error_code></error_code>
          <error_detail>The eagle may have perished.</error_detail>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-05T13:16:01Z</created_at>
          <updated_at type="datetime">2013-08-05T13:16:01Z</updated_at>
        </response>
        <payment_method>
          <token>8rkaeSF9LILlSyPpNEUsjkGotb6</token>
          <created_at type="datetime">2013-08-05T13:16:00Z</created_at>
          <updated_at type="datetime">2013-08-05T13:16:00Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <last_four_digits>1881</last_four_digits>
          <first_six_digits>411111</first_six_digits>
          <card_type>visa</card_type>
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
          <company>Acme</company>
          <full_name>Perrin Aybara</full_name>
          <payment_method_type>credit_card</payment_method_type>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <errors>
          </errors>
          <verification_value></verification_value>
          <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
          <number>XXXX-XXXX-XXXX-1881</number>
        </payment_method>
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

end
