require 'test_helper'

class FindPaymentMethodTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_find_card
    @environment.expects(:raw_ssl_request).returns(successful_get_card_response)

    card = @environment.find_payment_method(@card_token)
    assert_kind_of(Spreedly::CreditCard, card)
    assert_equal("FOGJFe89QtbJL8QvjaJNMH0UG50", card.token)
    assert_equal("alcatraz@occulators.org", card.email)
    assert_equal("4445", card.last_four_digits)
    assert_equal('XXXX-XXXX-XXXX-4445', card.number)
    assert_equal("<some_attribute>5</some_attribute>", card.data)
    assert_equal(1369504152, card.created_at.to_i)
    assert_equal(1369508044, card.updated_at.to_i)
    assert_equal('master', card.card_type)
    assert_equal('Alcatraz', card.first_name)
    assert_equal('Smedry', card.last_name)
    assert_equal('8', card.month)
    assert_equal('2020', card.year)
    assert_equal('123 Freedom Street', card.address1)
    assert_equal('Apt. 8', card.address2)
    assert_equal('Wanaque', card.city)
    assert_equal('NJ', card.state)
    assert_equal('USA', card.country)
    assert_equal('201.344.7712', card.phone_number)
  end


  private
  def successful_get_card_response
    MockResponse.succeeded <<-XML
      <payment_method>
        <token>FOGJFe89QtbJL8QvjaJNMH0UG50</token>
        <created_at type="datetime">2013-05-25T17:49:12Z</created_at>
        <updated_at type="datetime">2013-05-25T18:54:04Z</updated_at>
        <email>alcatraz@occulators.org</email>
        <data>
          <some_attribute>5</some_attribute>
        </data>
        <storage_state>retained</storage_state>
        <last_four_digits>4445</last_four_digits>
        <card_type>master</card_type>
        <first_name>Alcatraz</first_name>
        <last_name>Smedry</last_name>
        <month type="integer">8</month>
        <year type="integer">2020</year>
        <address1>123 Freedom Street</address1>
        <address2>Apt. 8</address2>
        <city>Wanaque</city>
        <state>NJ</state>
        <zip>02124</zip>
        <country>USA</country>
        <phone_number>201.344.7712</phone_number>
        <full_name>Alcatraz Smedry</full_name>
        <payment_method_type>credit_card</payment_method_type>
        <errors>
        </errors>
        <verification_value></verification_value>
        <number>XXXX-XXXX-XXXX-4445</number>
      </payment_method>
    XML
  end

  class MockResponse
    attr_reader :code, :body
    def self.succeeded(xml)
      MockResponse.new(200, xml)
    end

    def self.failed(xml)
      MockResponse.new(422, xml)
    end

    def initialize(code, body, headers={})
      @code, @body, @headers = code, body, headers
    end

    def [](header)
      @headers[header]
    end
  end
end
