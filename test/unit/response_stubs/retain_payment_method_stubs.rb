module RetainPaymentMethodStubs

  def successful_retain_response
    StubResponse.succeeded <<-XML
      <transaction>
        <token>DsmkqsjRvqcMGSCBUUuUiRw8tso</token>
        <created_at type="datetime">2013-08-05T18:31:51Z</created_at>
        <updated_at type="datetime">2013-08-05T18:31:51Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <transaction_type>RetainPaymentMethod</transaction_type>
        <state>succeeded</state>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <payment_method>
          <token>RXZDzDGxpqPV7v5ZNVO89n1qtTl</token>
          <created_at type="datetime">2013-08-05T18:31:51Z</created_at>
          <updated_at type="datetime">2013-08-05T18:31:51Z</updated_at>
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
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <errors>
          </errors>
          <verification_value></verification_value>
          <number>XXXX-XXXX-XXXX-4444</number>
        </payment_method>
      </transaction>
    XML
  end

  def failed_retain_response
    StubResponse.failed <<-XML
      <transaction>
        <token>2OLUmdUE7EFIdkb9tTnWyLPkxsF</token>
        <created_at type="datetime">2013-08-05T18:34:14Z</created_at>
        <updated_at type="datetime">2013-08-05T18:34:14Z</updated_at>
        <succeeded type="boolean">false</succeeded>
        <transaction_type>RetainPaymentMethod</transaction_type>
        <state>failed</state>
        <message key="messages.unable_to_retain_a_redacted_payment_method">The payment method has been redacted. Therefore, it cannot be retained.</message>
        <payment_method>
          <token>CpurR3zCfGcRC0tqwq9zp4zzIgf</token>
          <created_at type="datetime">2013-08-05T18:34:13Z</created_at>
          <updated_at type="datetime">2013-08-05T18:34:14Z</updated_at>
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
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <errors>
          </errors>
          <verification_value></verification_value>
          <number>XXXX-XXXX-XXXX-4444</number>
        </payment_method>
      </transaction>
    XML
  end

end
