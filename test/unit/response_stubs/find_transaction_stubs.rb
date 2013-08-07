module FindTransactionStubs

  def successful_get_transaction_response
    StubResponse.succeeded <<-XML
      <transaction>
        <token>2IFzBBh99rwjXKkZ0hkPVLjCBXL</token>
        <created_at type="datetime">2013-08-05T19:32:49Z</created_at>
        <updated_at type="datetime">2013-08-05T19:32:49Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <transaction_type>AddPaymentMethod</transaction_type>
        <retained type="boolean">true</retained>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <payment_method>
          <token>7sqmBrh8zS4Mgei6wOyYskFpghF</token>
          <created_at type="datetime">2013-08-05T19:32:49Z</created_at>
          <updated_at type="datetime">2013-08-05T19:32:49Z</updated_at>
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
      </transaction>
    XML
  end
end
