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
        <payment_method>
          <token>RAZy9RHW377y5MTtpb537CxLtwE</token>
          <created_at type="datetime">2013-08-13T19:57:06Z</created_at>
          <updated_at type="datetime">2013-08-13T19:57:06Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <last_four_digits>4444</last_four_digits>
          <card_type>master</card_type>
          <first_name>Mat</first_name>
          <last_name>Cauthon</last_name>
          <month type="integer">1</month>
          <year type="integer">2019</year>
          <address1 nil="true"/>
          <address2 nil="true"/>
          <city nil="true"/>
          <state nil="true"/>
          <zip nil="true"/>
          <country nil="true"/>
          <phone_number nil="true"/>
          <full_name>Mat Cauthon</full_name>
          <payment_method_type>credit_card</payment_method_type>
          <errors>
          </errors>
          <verification_value></verification_value>
          <number>XXXX-XXXX-XXXX-4444</number>
        </payment_method>
      </payment_methods>
    XML
  end
end
