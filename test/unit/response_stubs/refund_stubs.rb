module RefundStubs

  def successful_refund_response
    StubResponse.succeeded <<-XML
      <transaction>
        <amount type="integer">944</amount>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-08-05T16:37:13Z</created_at>
        <updated_at type="datetime">2013-08-05T16:37:13Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">true</succeeded>
        <state>succeeded</state>
        <token>JyQegcYcIFA2jUg22OYTGiUyXTR</token>
        <transaction_type>Credit</transaction_type>
        <order_id>99a1</order_id>
        <ip>182.129.106.102</ip>
        <description>LotsOCoffee</description>
        <merchant_name_descriptor>My Writeoff Inc.</merchant_name_descriptor>
        <merchant_location_descriptor>Tax Free Zone</merchant_location_descriptor>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_token>XYI0V2l4KC1cAm6Y3c2kG5loJaA</gateway_token>
        <gateway_transaction_id>44</gateway_transaction_id>
        <response>
          <success type="boolean">true</success>
          <message>Successful credit</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <error_code></error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-05T16:37:13Z</created_at>
          <updated_at type="datetime">2013-08-05T16:37:13Z</updated_at>
        </response>
        <reference_token>RkIAltzr49eXuWc7ajBjLLeKZt8</reference_token>
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

  def failed_refund_response
    StubResponse.failed <<-XML
      <transaction>
        <amount type="integer">44</amount>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-08-05T16:35:11Z</created_at>
        <updated_at type="datetime">2013-08-05T16:35:11Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">false</succeeded>
        <state>gateway_processing_failed</state>
        <token>UWB0L2Q2hwX1qy3Z8UdHd426icC</token>
        <transaction_type>Credit</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <description nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <message>Unable to process the credit transaction.</message>
        <gateway_token>GWUbHifwMEI8Lqyjz5H1zMbIC7M</gateway_token>
        <gateway_transaction_id></gateway_transaction_id>
        <response>
          <success type="boolean">false</success>
          <message>Unable to process the credit transaction.</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <error_code></error_code>
          <error_detail>The eagle is actually a dead duck.</error_detail>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-05T16:35:11Z</created_at>
          <updated_at type="datetime">2013-08-05T16:35:11Z</updated_at>
        </response>
        <reference_token>5UHTE8QU7lxsGYiBtRQRJn626kj</reference_token>
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

end
