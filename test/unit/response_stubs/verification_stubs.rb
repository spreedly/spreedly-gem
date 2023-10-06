module VerificationStubs

  def successful_verify_response
    StubResponse.succeeded <<-XML
      <transaction>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2014-07-03T19:43:19Z</created_at>
        <updated_at type="datetime">2014-07-03T19:43:20Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <token>CSCoubzCMgrD4FAv1CRmucVTxTQ</token>
        <state>succeeded</state>
        <retain_on_success type="boolean">false</retain_on_success>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>Verification</transaction_type>
        <order_id>99a1</order_id>
        <ip>182.129.106.102</ip>
        <description>LotsOCoffee</description>
        <merchant_name_descriptor>My Writeoff Inc.</merchant_name_descriptor>
        <merchant_location_descriptor>Tax Free Zone</merchant_location_descriptor>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_transaction_id>49</gateway_transaction_id>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_token>LoxFMxQJD5E1ksAwFWykUamaCKE</gateway_token>
        <response>
          <success type="boolean">true</success>
          <message>Successful verify</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <fraud_review type="boolean">false</fraud_review>
          <error_code/>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2014-07-03T19:43:19Z</created_at>
          <updated_at type="datetime">2014-07-03T19:43:19Z</updated_at>
        </response>
        <payment_method>
          <token>98626DYInHb4K86dp6GrocnZOW6</token>
          <created_at type="datetime">2014-07-03T19:43:18Z</created_at>
          <updated_at type="datetime">2014-07-03T19:43:19Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <test type="boolean">true</test>
          <last_four_digits>4444</last_four_digits>
          <first_six_digits>411111</first_six_digits>
          <card_type>master</card_type>
          <first_name>Perrin</first_name>
          <last_name>Aybara</last_name>
          <month type="integer">1</month>
          <year type="integer">2030</year>
          <address1 nil="true"/>
          <address2 nil="true"/>
          <city nil="true"/>
          <state nil="true"/>
          <zip nil="true"/>
          <country nil="true"/>
          <phone_number nil="true"/>
          <company>Acme</company>
          <full_name>Perrin Aybara</full_name>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <payment_method_type>credit_card</payment_method_type>
          <errors>
          </errors>
          <verification_value/>
          <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
          <number>XXXX-XXXX-XXXX-4444</number>
        </payment_method>
      </transaction>
    XML
  end

  def failed_verify_response
    StubResponse.failed <<-XML
      <transaction>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2014-07-03T19:44:28Z</created_at>
        <updated_at type="datetime">2014-07-03T19:44:28Z</updated_at>
        <succeeded type="boolean">false</succeeded>
        <token>LoXHEUXYFDCxGLGcG94JVh9FKmE</token>
        <state>gateway_processing_failed</state>
        <retain_on_success type="boolean">false</retain_on_success>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>Verification</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <description nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_transaction_id nil="true"/>
        <message>Unable to process the verify transaction.</message>
        <gateway_token>XpnCSoIOpESZsDMTxnXrcYmtWzq</gateway_token>
        <response>
          <success type="boolean">false</success>
          <message>Unable to process the verify transaction.</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <fraud_review type="boolean">false</fraud_review>
          <error_code/>
          <error_detail>What up with that?</error_detail>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2014-07-03T19:44:28Z</created_at>
          <updated_at type="datetime">2014-07-03T19:44:28Z</updated_at>
        </response>
        <payment_method>
          <token>M6oqAYOZe1OVnwhzNWr0DyWzV83</token>
          <created_at type="datetime">2014-07-03T19:44:27Z</created_at>
          <updated_at type="datetime">2014-07-03T19:44:27Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <test type="boolean">true</test>
          <last_four_digits>1881</last_four_digits>
          <first_six_digits>401288</first_six_digits>
          <card_type>visa</card_type>
          <first_name>Perrin</first_name>
          <last_name>Aybara</last_name>
          <month type="integer">1</month>
          <year type="integer">2030</year>
          <address1 nil="true"/>
          <address2 nil="true"/>
          <city nil="true"/>
          <state nil="true"/>
          <zip nil="true"/>
          <country nil="true"/>
          <phone_number nil="true"/>
          <company>Acme</company>
          <full_name>Perrin Aybara</full_name>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <payment_method_type>credit_card</payment_method_type>
          <errors>
          </errors>
          <verification_value/>
          <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
          <number>XXXX-XXXX-XXXX-1881</number>
        </payment_method>
      </transaction>
    XML
  end

end
