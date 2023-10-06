module ListPaymentMethodsStubs

  def successful_list_payment_methods_response
    StubResponse.succeeded <<-XML
      <payment_methods>
        <payment_method>
          <token>VICAwZCgWukqVVpBWJlCT4mNAoG</token>
          <created_at type="datetime">2013-08-13T19:57:05Z</created_at>
          <updated_at type="datetime">2013-08-13T19:57:05Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
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
          <payment_method_type>credit_card</payment_method_type>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <errors>
          </errors>
          <verification_value></verification_value>
          <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
          <number>XXXX-XXXX-XXXX-4444</number>
        </payment_method>
        <payment_method>
          <token>RAZy9RHW377y5MTtpb537CxLtwE</token>
          <created_at type="datetime">2013-08-13T19:57:06Z</created_at>
          <updated_at type="datetime">2013-08-13T19:57:06Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <last_four_digits>4444</last_four_digits>
          <first_six_digits>411111</first_six_digits>
          <card_type>master</card_type>
          <first_name>Mat</first_name>
          <last_name>Cauthon</last_name>
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
          <full_name>Mat Cauthon</full_name>
          <payment_method_type>credit_card</payment_method_type>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <errors>
          </errors>
          <verification_value></verification_value>
          <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
          <number>XXXX-XXXX-XXXX-4444</number>
        </payment_method>
        <payment_method>
          <token>RllfVekUSmqgEP8rpS2M1z9HG6C</token>
          <created_at type="datetime">2014-05-30T19:51:48Z</created_at>
          <updated_at type="datetime">2014-05-30T19:51:48Z</updated_at>
          <gateway_type>test</gateway_type>
          <storage_state>retained</storage_state>
          <third_party_token>test_vault:4111111111111111</third_party_token>
          <payment_method_type>third_party_token</payment_method_type>
          <errors>
          </errors>
        </payment_method>
        <payment_method>
          <token>KX7Y1oePqya4JAQ5bMIY9Vi87xb</token>
          <created_at type="datetime">2014-05-21T21:21:32Z</created_at>
          <updated_at type="datetime">2014-05-22T03:42:27Z</updated_at>
          <email nil="true"/>
          <data>
            <blah>whatever</blah>
          </data>
          <storage_state>retained</storage_state>
          <test type="boolean">true</test>
          <payment_method_type>sprel</payment_method_type>
          <errors>
          </errors>
        </payment_method>
        <payment_method>
          <token>47KP5QXHYuv5N2LKu8hExMY7Okr</token>
          <created_at type="datetime">2014-05-21T21:08:33Z</created_at>
          <updated_at type="datetime">2014-05-21T21:08:33Z</updated_at>
          <email nil="true"/>
          <data nil="true"/>
          <storage_state>cached</storage_state>
          <test type="boolean">true</test>
          <full_name>Bob Smith</full_name>
          <bank_name>First Bank of Elbonia</bank_name>
          <account_type>checking</account_type>
          <account_holder_type>personal</account_holder_type>
          <routing_number_display_digits>021</routing_number_display_digits>
          <account_number_display_digits>4321</account_number_display_digits>
          <first_name>Bob</first_name>
          <last_name>Smith</last_name>
          <payment_method_type>bank_account</payment_method_type>
          <errors>
          </errors>
          <routing_number>021*</routing_number>
          <account_number>*4321</account_number>
        </payment_method>
      </payment_methods>
    XML
  end
end
