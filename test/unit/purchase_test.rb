require 'test_helper'

class PurchaseTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_purchase
    t = purchase_using(successful_purchase_response)

    assert_kind_of(Spreedly::Purchase, t)
    assert_equal 'Btcyks35m4JLSNOs9ymJoNQLjeX', t.token
    assert_equal 144, t.amount
    assert_equal true, t.on_test_gateway
    assert_equal true, t.on_test_gateway?
    assert_equal Time.parse("2013-07-31 19:46:26 UTC"), t.created_at
    assert_equal Time.parse("2013-07-31 19:46:32 UTC"), t.updated_at
    assert_equal 'USD', t.currency_code
    assert_equal true, t.succeeded
    assert_equal true, t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal '187A', t.order_id
    assert_equal '', t.ip
    assert_equal '4 Shardblades', t.description
    assert_equal '', t.merchant_name_descriptor
    assert_equal '', t.merchant_location_descriptor
    assert_equal 'YOaCn5a9xRaBTGgmGAWbkgWUuqv', t.gateway_token
    assert_equal '8xXXIPGXTaPXysDA5OUpgnjTEjK', t.payment_method.token

    # TODO handle response
  end

  def test_failed_purchase
    t = purchase_using(failed_purchase_response)

    assert_kind_of(Spreedly::Purchase, t)
    assert_equal 'RxkxK78ZlvDiXRQRnyuJM5ee0Ww', t.token
    assert_equal 5148, t.amount
    assert_equal false, t.succeeded
    assert_equal false, t.succeeded?
    assert_equal 'gateway_processing_failed', t.state

    # TODO handle response
  end

  private
  def purchase_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.purchase_on_gateway("IgnoredGatewayTokenSinceResponseIsStubbed", "IgnoredPaymentMethodTokenSinceResponseIsStubbed", 5921)
  end

  def successful_purchase_response
    StubResponse.succeeded <<-XML
      <transaction>
        <amount type="integer">144</amount>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-07-31T19:46:26Z</created_at>
        <updated_at type="datetime">2013-07-31T19:46:32Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">true</succeeded>
        <state>succeeded</state>
        <token>Btcyks35m4JLSNOs9ymJoNQLjeX</token>
        <transaction_type>Purchase</transaction_type>
        <order_id>187A</order_id>
        <ip nil="true"/>
        <description>4 Shardblades</description>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <gateway_token>YOaCn5a9xRaBTGgmGAWbkgWUuqv</gateway_token>
        <response>
          <success type="boolean">true</success>
          <message>Successful purchase</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <error_code></error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-07-31T19:46:26Z</created_at>
          <updated_at type="datetime">2013-07-31T19:46:26Z</updated_at>
        </response>
        <payment_method>
          <token>8xXXIPGXTaPXysDA5OUpgnjTEjK</token>
          <created_at type="datetime">2013-07-31T19:46:25Z</created_at>
          <updated_at type="datetime">2013-07-31T19:46:26Z</updated_at>
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
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

  def failed_purchase_response
    StubResponse.failed <<-XML
      <transaction>
        <amount type="integer">5148</amount>
        <on_test_gateway type="boolean">true</on_test_gateway>
        <created_at type="datetime">2013-07-31T19:51:57Z</created_at>
        <updated_at type="datetime">2013-07-31T19:51:57Z</updated_at>
        <currency_code>USD</currency_code>
        <succeeded type="boolean">false</succeeded>
        <state>gateway_processing_failed</state>
        <token>RxkxK78ZlvDiXRQRnyuJM5ee0Ww</token>
        <transaction_type>Purchase</transaction_type>
        <order_id nil="true"/>
        <ip nil="true"/>
        <description nil="true"/>
        <merchant_name_descriptor nil="true"/>
        <merchant_location_descriptor nil="true"/>
        <gateway_specific_fields nil="true"/>
        <gateway_specific_response_fields nil="true"/>
        <message>Unable to process the purchase transaction.</message>
        <gateway_token>Y6jMbUCm2oz6QTpavzp0xLaV9mk</gateway_token>
        <response>
          <success type="boolean">false</success>
          <message>Unable to process the purchase transaction.</message>
          <avs_code nil="true"/>
          <avs_message nil="true"/>
          <cvv_code nil="true"/>
          <cvv_message nil="true"/>
          <pending type="boolean">false</pending>
          <error_code></error_code>
          <error_detail nil="true"/>
          <cancelled type="boolean">false</cancelled>
          <created_at type="datetime">2013-07-31T19:51:57Z</created_at>
          <updated_at type="datetime">2013-07-31T19:51:57Z</updated_at>
        </response>
        <payment_method>
          <token>H0kioCnUZ8YbQ9rhqJv6zyav01Q</token>
          <created_at type="datetime">2013-07-31T19:51:57Z</created_at>
          <updated_at type="datetime">2013-07-31T19:51:57Z</updated_at>
          <email>perrin@wot.com</email>
          <data nil="true"/>
          <storage_state>retained</storage_state>
          <last_four_digits>1881</last_four_digits>
          <card_type>visa</card_type>
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
          <number>XXXX-XXXX-XXXX-1881</number>
        </payment_method>
        <api_urls>
        </api_urls>
      </transaction>
    XML
  end

end
