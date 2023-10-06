module UpdateCreditCardStubs

  def successful_update_credit_card_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>LagdXxK2VXC6DQ5XxP6UdjRJXBn</token>
        <created_at type="datetime">2013-08-13T21:33:09Z</created_at>
        <updated_at type="datetime">2013-08-13T21:33:10Z</updated_at>
        <email>cauthon@wot.com</email>
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
      XML
  end
end
