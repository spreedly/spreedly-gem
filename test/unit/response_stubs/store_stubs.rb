module StoreStubs

  def successful_store_response
    StubResponse.succeeded <<-XML
      <transaction>
        <created_at type="dateTime">2015-03-20T17:32:04Z</created_at>
        <updated_at type="dateTime">2015-03-20T17:32:04Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <token>1gOXWjBEiF83cylf5t4WLe4uULI</token>
        <state>succeeded</state>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>Store</transaction_type>
        <third_party_token nil="true"/>
        <gateway_transaction_id nil="true"/>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <payment_method>
          <token>McNbLlg7Ytmyyuh45PCsyfHas1r</token>
          <created_at type="dateTime">2015-03-20T17:32:04Z</created_at>
          <updated_at type="dateTime">2015-03-20T17:32:04Z</updated_at>
          <gateway_type>test</gateway_type>
          <storage_state>retained</storage_state>
          <third_party_token>test_vault:5555555555554444</third_party_token>
          <payment_method_type>third_party_token</payment_method_type>
          <errors>
          </errors>
        </payment_method>
        <basis_payment_method>
          <token>GQzlYKsJho12S2VswhsY8Q9qCmM</token>
          <created_at type="dateTime">2015-03-20T17:32:03Z</created_at>
          <updated_at type="dateTime">2015-03-20T17:32:04Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <test type="boolean">true</test>
          <last_four_digits>4444</last_four_digits>
          <first_six_digits>555555</first_six_digits>
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
          <company>Acme</company>
          <full_name>Perrin Aybara</full_name>
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
          <verification_value/>
          <number>XXXX-XXXX-XXXX-4444</number>
        </basis_payment_method>
        <response>
          <success type="boolean">true</success>
          <message>Successful store</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <result_unknown type="boolean">false</result_unknown>
          <error_code/>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <fraud_review nil="true"/>
          <created_at type="dateTime">2015-03-20T17:32:04Z</created_at>
          <updated_at type="dateTime">2015-03-20T17:32:04Z</updated_at>
        </response>
      </transaction>
    XML
  end

  def failed_store_response
    StubResponse.failed <<-XML
      <transaction>
        <created_at type="dateTime">2015-03-20T17:35:20Z</created_at>
        <updated_at type="dateTime">2015-03-20T17:35:20Z</updated_at>
        <succeeded type="boolean">false</succeeded>
        <token>88PvId4mseKsO09KlkcoilsbfMW</token>
        <state>gateway_processing_failed</state>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>Store</transaction_type>
        <third_party_token nil="true"/>
        <gateway_transaction_id nil="true"/>
        <message>Unable to store card</message>
        <basis_payment_method>
          <token>E0iLmJB1eHtJJXf7rpmk2UimCVi</token>
          <created_at type="dateTime">2015-03-20T17:35:19Z</created_at>
          <updated_at type="dateTime">2015-03-20T17:35:19Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <test type="boolean">true</test>
          <last_four_digits>1119</last_four_digits>
          <first_six_digits>421765</first_six_digits>
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
          <verification_value/>
          <number>XXXX-XXXX-XXXX-1119</number>
        </basis_payment_method>
        <response>
          <success type="boolean">false</success>
          <message>Unable to store card</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <result_unknown type="boolean">false</result_unknown>
          <error_code/>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <fraud_review nil="true"/>
          <created_at type="dateTime">2015-03-20T17:35:20Z</created_at>
          <updated_at type="dateTime">2015-03-20T17:35:20Z</updated_at>
        </response>
      </transaction>
    XML
  end

end
