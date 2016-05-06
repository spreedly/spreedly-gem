module AddCreditCardStubs

  def successful_add_credit_card_response
    StubResponse.succeeded <<-XML
      <transaction>
        <token>6wxjN6HcDik8e3mAhBaaoVGSImH</token>
        <created_at type="datetime">2013-08-02T18:04:45Z</created_at>
        <updated_at type="datetime">2013-08-02T18:04:45Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <transaction_type>AddPaymentMethod</transaction_type>
        <retained type="boolean">false</retained>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <payment_method>
          <token>AXaBXfVUqhaGMg8ytf8isiMAAL9</token>
          <created_at type="datetime">2013-08-02T18:04:45Z</created_at>
          <updated_at type="datetime">2013-08-02T18:04:45Z</updated_at>
          <email>ellend@mistborn.com</email>
          <data>Don't test everything here, since find_payment_method tests it all.</data>
          <storage_state>cached</storage_state>
          <last_four_digits>4942</last_four_digits>
          <first_six_digits>411111</first_six_digits>
          <card_type>master</card_type>
          <first_name>Eland</first_name>
          <last_name>Venture</last_name>
          <month type="integer">1</month>
          <year type="integer">2019</year>
          <address1>3 Main</address1>
          <address2>Suite 7</address2>
          <city>Oakland</city>
          <state>NJ</state>
          <zip>33221</zip>
          <country>UK</country>
          <phone_number>43</phone_number>
          <company>Acme</company>
          <full_name>Eland Venture</full_name>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <payment_method_type>credit_card</payment_method_type>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <errors>
          </errors>
          <verification_value></verification_value>
          <fingerprint>ac5579920013cc571e506805f1c8f3220eff</fingerprint>
          <number>XXXX-XXXX-XXXX-4942</number>
        </payment_method>
      </transaction>
      XML
  end

end
