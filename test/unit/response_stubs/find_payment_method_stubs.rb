module FindPaymentMethodStubs

  def successful_get_card_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>ROGJFe89QtbJL8QvjaJNMH0UG50</token>
        <created_at type="datetime">2013-05-25T17:49:12Z</created_at>
        <updated_at type="datetime">2013-05-25T18:54:04Z</updated_at>
        <email>alcatraz@occulators.org</email>
        <data>
          <some_attribute>5</some_attribute>
        </data>
        <storage_state>retained</storage_state>
        <last_four_digits>4445</last_four_digits>
        <first_six_digits>411111</first_six_digits>
        <card_type>master</card_type>
        <first_name>Alcatraz</first_name>
        <last_name>Smedry</last_name>
        <month type="integer">8</month>
        <year type="integer">2020</year>
        <address1>123 Freedom Street</address1>
        <address2>Apt. 8</address2>
        <city>Wanaque</city>
        <state>NJ</state>
        <zip>02124</zip>
        <country>USA</country>
        <phone_number>201.344.7712</phone_number>
        <company>Acme</company>
        <full_name>Alcatraz Smedry</full_name>
        <payment_method_type>credit_card</payment_method_type>
        <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
        <errors>
        </errors>
        <verification_value></verification_value>
        <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
        <number>XXXX-XXXX-XXXX-4445</number>
      </payment_method>
    XML
  end

  def successful_get_invalid_card_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>CrY4e6wa3Jf4SMUZlvjFelW2YnQ</token>
        <created_at type="datetime">2013-07-19T17:05:18Z</created_at>
        <updated_at type="datetime">2013-07-20T05:26:01Z</updated_at>
        <email nil="true"/>
        <data>
          <how_many>2</how_many>
        </data>
        <storage_state>redacted</storage_state>
        <last_four_digits></last_four_digits>
        <first_six_digits></first_six_digits>
        <card_type nil="true"/>
        <first_name></first_name>
        <last_name></last_name>
        <month type="integer">8</month>
        <year nil="true"/>
        <address1 nil="true"/>
        <address2 nil="true"/>
        <city nil="true"/>
        <state nil="true"/>
        <zip nil="true"/>
        <country nil="true"/>
        <phone_number nil="true"/>
        <company>Acme</company>
        <full_name></full_name>
        <payment_method_type>credit_card</payment_method_type>
        <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
        <errors>
          <error attribute="first_name" key="errors.blank">First name can't be blank</error>
          <error attribute="last_name" key="errors.blank">Last name can't be blank</error>
          <error attribute="year" key="errors.expired">Year is expired</error>
          <error attribute="year" key="errors.invalid">Year is invalid</error>
          <error attribute="number" key="errors.blank">Number can't be blank</error>
        </errors>
        <verification_value></verification_value>
        <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
        <number>XXXX-XXXX-XXXX-1881</number>
      </payment_method>
    XML
  end

  def successful_get_sprel_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>RZf8ZQgvmgOfdWaRtAzMLXPSQbk</token>
        <created_at type="datetime">2013-04-26T13:11:07Z</created_at>
        <updated_at type="datetime">2013-04-26T13:18:21Z</updated_at>
        <email>neelix@voyager.com</email>
        <data>Some Pretty Data</data>
        <storage_state>cached</storage_state>
        <payment_method_type>sprel</payment_method_type>
        <errors>
        </errors>
      </payment_method>
    XML
  end

  def successful_get_paypal_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>X7DkJT3NUMNMJ0ZVvRMJBEyUe9B</token>
        <created_at type="datetime">2013-07-31T16:26:59Z</created_at>
        <updated_at type="datetime">2013-07-31T16:27:26Z</updated_at>
        <email>shaun@mason.com</email>
        <data nil="true"/>
        <storage_state>retained</storage_state>
        <payment_method_type>paypal</payment_method_type>
        <errors>
        </errors>
      </payment_method>
    XML
  end

  def successful_get_bank_account_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>seeQDV0jwJwFa1FUUsph6kPMTj</token>
        <created_at type="datetime">2013-08-16T17:20:33Z</created_at>
        <updated_at type="datetime">2013-08-16T17:20:33Z</updated_at>
        <email>daniel@waterhouse.com</email>
        <data>GeekyNote</data>
        <storage_state>cached</storage_state>
        <full_name>Daniel Waterhouse</full_name>
        <bank_name>First Bank of Crypto</bank_name>
        <account_type>checking</account_type>
        <account_holder_type>personal</account_holder_type>
        <routing_number_display_digits>021</routing_number_display_digits>
        <account_number_display_digits>4321</account_number_display_digits>
        <first_name>Daniel</first_name>
        <last_name>Waterhouse</last_name>
        <payment_method_type>bank_account</payment_method_type>
        <errors>
        </errors>
        <routing_number>021*</routing_number>
        <account_number>*4321</account_number>
      </payment_method>
    XML
  end

end
