module CaptureStubs

  def successful_capture_response
    StubResponse.succeeded <<-XML
      <transaction>
        <amount type="integer">801</amount>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-08-05T13:58:50Z</created_at>
        <updated_at type="datetime">2013-08-05T13:58:50Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">true</succeeded>
        <state>succeeded</state>
        <token>T41uDjYsxGybSsp7RHuRTohMjg2</token>
        <transaction_type>Capture</transaction_type>
        <order_id>99a1</order_id>
        <email>joe@example.com</email>
        <ip>182.129.106.102</ip>
        <description>LotsOCoffee</description>
        <merchant_name_descriptor>My Writeoff Inc.</merchant_name_descriptor>
        <merchant_location_descriptor>Tax Free Zone</merchant_location_descriptor>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields>
          <stripe>
            <card_funding>credit</card_funding>
          </stripe>
        </gateway_specific_response_fields>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_token>SoPblCOGDwaRyym68XGWeRiCy1C</gateway_token>
        <gateway_transaction_id>44</gateway_transaction_id>
        <response>
          <success type="boolean">true</success>
          <message>Successful capture</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <fraud_review type="boolean">false</fraud_review>
          <error_code></error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-05T13:58:50Z</created_at>
          <updated_at type="datetime">2013-08-05T13:58:50Z</updated_at>
        </response>
        <reference_token>PH6U2tyFWtDSVp88bNW2nnGy5rk</reference_token>
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

  def failed_capture_response
    StubResponse.failed <<-XML
      <transaction>
        <amount type="integer">44</amount>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-08-05T14:25:05Z</created_at>
        <updated_at type="datetime">2013-08-05T14:25:05Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">false</succeeded>
        <state>gateway_processing_failed</state>
        <token>Z4XAoSG11rd4zo9p9sRxpstKufX</token>
        <transaction_type>Capture</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <email nil="true"/>
        <description nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <message>Unable to process the capture transaction.</message>
        <gateway_token>K0L5hw4rhLx1xMTL2cfHWx9D1rX</gateway_token>
        <gateway_transaction_id></gateway_transaction_id>
        <response>
          <success type="boolean">false</success>
          <message>Unable to process the capture transaction.</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <fraud_review type="boolean">false</fraud_review>
          <error_code></error_code>
          <error_detail>The eagle has hit the window.</error_detail>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-05T14:25:05Z</created_at>
          <updated_at type="datetime">2013-08-05T14:25:05Z</updated_at>
        </response>
        <reference_token>6qTuvZtUlS6eXylk6a2VKUGjYS0</reference_token>
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

end
