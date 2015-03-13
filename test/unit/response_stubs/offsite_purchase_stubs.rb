module OffsitePurchaseStubs

  def pending_offsite_purchase_response
    StubResponse.succeeded <<-XML
      <transaction>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="dateTime">2015-03-13T02:36:51Z</created_at>
        <updated_at type="dateTime">2015-03-13T02:36:51Z</updated_at>
        <succeeded type="boolean">false</succeeded>
        <state>pending</state>
        <token>offsite-purchase-token</token>
        <transaction_type>OffsitePurchase</transaction_type>
        <order_id>123</order_id>
        <ip>127.0.0.1</ip>
        <description>3 Widgets</description>
        <email nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <gateway_transaction_id nil="true"/>
        <amount type="integer">100</amount>
        <currency_code>USD</currency_code>
        <reference nil="true"/>
        <message key="messages.transaction_pending">Pending</message>
        <gateway_token>offsite-gateway-token</gateway_token>
        <api_urls>
          <callback_conversations>https://core.spreedly.com/v1/callbacks/Cxo4V7LC94vcAoIzG3dK0onF1H7/conversations.xml</callback_conversations>
        </api_urls>
        <payment_method>
          <token>offsite-payment-method-token</token>
          <created_at type="dateTime">2015-03-13T02:36:49Z</created_at>
          <updated_at type="dateTime">2015-03-13T02:36:49Z</updated_at>
          <email>me@joey.io</email>
          <data nil="true"/>
          <storage_state>cached</storage_state>
          <test type="boolean">true</test>
          <payment_method_type>sprel</payment_method_type>
          <errors>
          </errors>
        </payment_method>
        <callback_url>http://forward.joey.io/callback</callback_url>
        <redirect_url>http://me-joey-io.lvh.me:3000/orders/571594BB09579F9658492BF2/confirm</redirect_url>
        <checkout_url>https://core.spreedly.com/sprel/KqNB39FEMOqepEtqqNBfsVZngfe/checkout/4utFLYYazAB5aaca8BgFgwWMRg0</checkout_url>
        <checkout_form>
          <![CDATA[
      <form action="" method="POST">
        <div>
          <input name="PaReq" value="" type="hidden"/>
          <input name="MD" value="" type="hidden"/>
          <input name="TermUrl" value="https://core.spreedly.com/transaction/4utFLYYazAB5aaca8BgFgwWMRg0/redirect" type="hidden"/>
          <input name="Complete" value="Authorize Transaction" type="submit"/>
        </div>
      </form>
      ]]>
        </checkout_form>
        <setup_response>
          <success type="boolean">true</success>
          <message>Setup response message</message>
          <error_code>899</error_code>
          <checkout_url>https://checkout.com</checkout_url>
          <created_at type="dateTime">2015-03-13T02:36:51Z</created_at>
          <updated_at type="dateTime">2015-03-13T02:36:51Z</updated_at>
        </setup_response>
      </transaction>
    XML
  end

  def failed_offsite_purchase_response
    StubResponse.failed <<-XML
      <transaction>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="dateTime">2015-03-13T02:36:51Z</created_at>
        <updated_at type="dateTime">2015-03-13T02:36:51Z</updated_at>
        <succeeded type="boolean">false</succeeded>
        <state>gateway_processing_failed</state>
        <token>offsite-purchase-token</token>
        <transaction_type>OffsitePurchase</transaction_type>
        <order_id>123</order_id>
        <ip>127.0.0.1</ip>
        <description>3 Widgets</description>
        <email nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <gateway_transaction_id nil="true"/>
        <amount type="integer">100</amount>
        <currency_code>USD</currency_code>
        <reference nil="true"/>
        <message key="messages.transaction_pending">Pending</message>
        <gateway_token>offsite-gateway-token</gateway_token>
        <api_urls>
          <callback_conversations>https://core.spreedly.com/v1/callbacks/Cxo4V7LC94vcAoIzG3dK0onF1H7/conversations.xml</callback_conversations>
        </api_urls>
        <payment_method>
          <token>offsite-payment-method-token</token>
          <created_at type="dateTime">2015-03-13T02:36:49Z</created_at>
          <updated_at type="dateTime">2015-03-13T02:36:49Z</updated_at>
          <email>me@joey.io</email>
          <data nil="true"/>
          <storage_state>cached</storage_state>
          <test type="boolean">true</test>
          <payment_method_type>sprel</payment_method_type>
          <errors>
          </errors>
        </payment_method>
        <callback_url>http://forward.joey.io/callback</callback_url>
        <redirect_url>http://me-joey-io.lvh.me:3000/orders/571594BB09579F9658492BF2/confirm</redirect_url>
        <checkout_url>https://core.spreedly.com/sprel/KqNB39FEMOqepEtqqNBfsVZngfe/checkout/4utFLYYazAB5aaca8BgFgwWMRg0</checkout_url>
        <checkout_form>
          <![CDATA[
      <form action="" method="POST">
        <div>
          <input name="PaReq" value="" type="hidden"/>
          <input name="MD" value="" type="hidden"/>
          <input name="TermUrl" value="https://core.spreedly.com/transaction/4utFLYYazAB5aaca8BgFgwWMRg0/redirect" type="hidden"/>
          <input name="Complete" value="Authorize Transaction" type="submit"/>
        </div>
      </form>
      ]]>
        </checkout_form>
        <setup_response>
          <success type="boolean">true</success>
          <message>Setup response message</message>
          <error_code>899</error_code>
          <checkout_url>https://checkout.com</checkout_url>
          <created_at type="dateTime">2015-03-13T02:36:51Z</created_at>
          <updated_at type="dateTime">2015-03-13T02:36:51Z</updated_at>
        </setup_response>
      </transaction>
    XML
  end

end
