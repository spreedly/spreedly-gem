module DeliverPaymentMethodStubs

  def successful_deliver_payment_method_response
    StubResponse.succeeded <<-XML
      <transaction>
        <token>QguSkyc5F49S2P68RSbA2Eszkhr</token>
        <transaction_type>DeliverPaymentMethod</transaction_type>
        <state>succeeded</state>
        <created_at>2014-06-20T20:24:57Z</created_at>
        <updated_at>2014-06-20T20:24:57Z</updated_at>
        <succeeded>true</succeeded>
        <message>Succeeded!</message>
        <response>
          <status>200</status>
          <headers>
            <![CDATA[Date: Fri, 20 Jun 2014 20:24:57 GMT
      Server: Apache
      Access-Control-Allow-Origin: *
      Vary: Accept-Encoding
      Content-Length: 142
      Connection: close
      Content-Type: text/html]]>
          </headers>
          <body>
            <![CDATA[Successfully dumped 0 post variables.
      View it at http://www.posttestserver.com/data/2014/06/20/13.24.571852460525
      Post body was 69 chars long.]]>
          </body>
        </response>
        <receiver>
          <receiver_type>test</receiver_type>
          <token>YRfLgloedGsbYHj2YQlAo37Zjqb</token>
          <hostnames>http://posttestserver.com</hostnames>
          <state>retained</state>
          <created_at>2014-06-20T20:24:56Z</created_at>
          <updated_at>2014-06-20T20:24:56Z</updated_at>
          <credentials>
            <credential>
              <name>app-id</name>
              <value>1234</value>
              <safe>true</safe>
            </credential>
            <credential>
              <name>app-secret</name>
            </credential>
          </credentials>
        </receiver>
        <payment_method>
          <token>TUwHIV9A3CiEizatDZFuic6C9la</token>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <email nil="true"/>
          <created_at>2014-06-03T14:59:27Z</created_at>
          <updated_at>2014-06-20T20:24:57Z</updated_at>
          <errors/>
          <payment_method_type>credit_card</payment_method_type>
          <first_name>Torrance</first_name>
          <last_name>Dooley</last_name>
          <full_name>Torrance Dooley</full_name>
          <card_type>visa</card_type>
          <last_four_digits>1111</last_four_digits>
          <first_six_digits>411111</first_six_digits>
          <month>4</month>
          <year>2020</year>
          <address1 nil="true"/>
          <address2 nil="true"/>
          <city nil="true"/>
          <state nil="true"/>
          <zip nil="true"/>
          <country nil="true"/>
          <phone_number nil="true"/>
          <eligible_for_card_updater>true</eligible_for_card_updater>
          <verification_value></verification_value>
          <number>XXXX-XXXX-XXXX-1111</number>
        </payment_method>
      </transaction>
    XML
  end

end
