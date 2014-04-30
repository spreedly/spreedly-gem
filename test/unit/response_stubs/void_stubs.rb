module VoidStubs

  def successful_void_response
    StubResponse.succeeded <<-XML
      <transaction>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-08-01T19:05:53Z</created_at>
        <updated_at type="datetime">2013-08-01T19:05:53Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <token>YutwWIoICGiFvSWUQbb9LTyjfnF</token>
        <state>succeeded</state>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>Void</transaction_type>
        <order_id>49J</order_id>
        <ip>102.122.012.111</ip>
        <description>Wonderful Description</description>
        <merchant_name_descriptor>DopeCorp</merchant_name_descriptor>
        <merchant_location_descriptor>Somewhere</merchant_location_descriptor>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_token>EuXlDMZEMZfrHSvE9tkRzaW8j0z</gateway_token>
        <reference_token>CjedAratpuiT3CMmln4t3oZFvOS</reference_token>
        <gateway_transaction_id>44</gateway_transaction_id>
        <response>
          <success type="boolean">true</success>
          <message>Successful void</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <error_code></error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-01T19:05:53Z</created_at>
          <updated_at type="datetime">2013-08-01T19:05:53Z</updated_at>
        </response>
      </transaction>
    XML
  end

  def failed_void_response
    StubResponse.failed <<-XML
      <transaction>
        <on_test_gateway type="boolean">false</on_test_gateway>
        <created_at type="datetime">2013-08-01T19:48:41Z</created_at>
        <updated_at type="datetime">2013-08-01T19:48:42Z</updated_at>
        <succeeded type="boolean">false</succeeded>
        <token>39gMhrti9KGiuLXa9suYL3kn3st</token>
        <state>gateway_processing_failed</state>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <transaction_type>Void</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <description nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <message>Transaction id is invalid.</message>
        <gateway_token>2AocQ8IUvnrr6J0xPGW7QbrMX6E</gateway_token>
        <reference_token>KNFrnpBYd9kFohOBZVL6GEmSGJB</reference_token>
        <gateway_transaction_id></gateway_transaction_id>
        <response>
          <success type="boolean">false</success>
          <message>Transaction id is invalid.</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <error_code>10609</error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-08-01T19:48:42Z</created_at>
          <updated_at type="datetime">2013-08-01T19:48:42Z</updated_at>
        </response>
      </transaction>
    XML
  end

end
