require 'test_helper'

class FindPaymentMethodTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_find_card
    card = find_using(successful_get_card_response)

    assert_kind_of(Spreedly::CreditCard, card)
    assert_equal("ROGJFe89QtbJL8QvjaJNMH0UG50", card.token)
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
    assert_equal('02124', card.zip)
    assert_equal('USA', card.country)
    assert_equal('201.344.7712', card.phone_number)
    assert_equal('retained', card.storage_state)
  end

  def test_find_valid_card
    card = find_using(successful_get_card_response)
    assert card.valid?
    assert_equal([], card.errors)
  end

  def test_find_invalid_card
    card = find_using(successful_get_invalid_card_response)

    assert !card.valid?
    expected_errors = [
      { attribute: "first_name", key: "errors.blank", text: "First name can't be blank" },
      { attribute: "last_name", key: "errors.blank", text: "Last name can't be blank" },
      { attribute: "year", key: "errors.expired", text: "Year is expired" },
      { attribute: "year", key: "errors.invalid", text: "Year is invalid" },
      { attribute: "number", key: "errors.blank", text: "Number can't be blank" }
    ]

    assert_equal(expected_errors, card.errors)
  end

  def test_successfully_find_sprel
    sprel = find_using(successful_get_sprel_response)

    assert_kind_of(Spreedly::Sprel, sprel)
    assert_equal "RZf8ZQgvmgOfdWaRtAzMLXPSQbk", sprel.token
    assert_equal "neelix@voyager.com", sprel.email
    assert_equal(1366981867, sprel.created_at.to_i)
    assert_equal(1366982301, sprel.updated_at.to_i)
    assert_equal("Some Pretty Data", sprel.data)
    assert_equal("cached", sprel.storage_state)
  end

  def test_successfully_find_paypal
    paypal = find_using(successful_get_paypal_response)

    assert_kind_of(Spreedly::Paypal, paypal)
    assert_equal "X7DkJT3NUMNMJ0ZVvRMJBEyUe9B", paypal.token
    assert_equal "shaun@mason.com", paypal.email
    assert_equal(1375288019, paypal.created_at.to_i)
    assert_equal(1375288046, paypal.updated_at.to_i)
    assert_equal("", paypal.data)
    assert_equal("retained", paypal.storage_state)
  end

  private
  def find_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.find_payment_method("IgnoredTokenSinceResponseIsStubbed")
  end

  def successful_get_card_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>ROGJFe89QtbJL8QvjaJNMH0UG50</token>
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

  def successful_get_invalid_card_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>CrY4e6wa3Jf4SMUZlvjFelW2YnQ</token>
        <created_at type="datetime">2013-07-19T17:05:18Z</created_at>
        <updated_at type="datetime">2013-07-20T05:26:01Z</updated_at>
        <email nil="true"/>
        <data>
          <how_many>2</how_many>
        </data>
        <storage_state>redacted</storage_state>
        <last_four_digits>1881</last_four_digits>
        <card_type nil="true"/>
        <first_name></first_name>
        <last_name></last_name>
        <month type="integer">8</month>
        <year nil="true"/>
        <address1 nil="true"/>
        <address2 nil="true"/>
        <city nil="true"/>
        <state nil="true"/>
        <zip nil="true"/>
        <country nil="true"/>
        <phone_number nil="true"/>
        <full_name></full_name>
        <payment_method_type>credit_card</payment_method_type>
        <errors>
          <error attribute="first_name" key="errors.blank">First name can't be blank</error>
          <error attribute="last_name" key="errors.blank">Last name can't be blank</error>
          <error attribute="year" key="errors.expired">Year is expired</error>
          <error attribute="year" key="errors.invalid">Year is invalid</error>
          <error attribute="number" key="errors.blank">Number can't be blank</error>
        </errors>
        <verification_value></verification_value>
        <number>XXXX-XXXX-XXXX-1881</number>
      </payment_method>
    XML
  end

  def successful_get_sprel_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>RZf8ZQgvmgOfdWaRtAzMLXPSQbk</token>
        <created_at type="datetime">2013-04-26T13:11:07Z</created_at>
        <updated_at type="datetime">2013-04-26T13:18:21Z</updated_at>
        <email>neelix@voyager.com</email>
        <data>Some Pretty Data</data>
        <storage_state>cached</storage_state>
        <payment_method_type>sprel</payment_method_type>
        <errors>
        </errors>
      </payment_method>
    XML
  end

  def successful_get_paypal_response
    StubResponse.succeeded <<-XML
      <payment_method>
        <token>X7DkJT3NUMNMJ0ZVvRMJBEyUe9B</token>
        <created_at type="datetime">2013-07-31T16:26:59Z</created_at>
        <updated_at type="datetime">2013-07-31T16:27:26Z</updated_at>
        <email>shaun@mason.com</email>
        <data nil="true"/>
        <storage_state>retained</storage_state>
        <payment_method_type>paypal</payment_method_type>
        <errors>
        </errors>
      </payment_method>
    XML
  end

  class StubResponse
    attr_reader :code, :body
    def self.succeeded(xml)
      StubResponse.new(200, xml)
    end

    def self.failed(xml)
      StubResponse.new(422, xml)
    end

    def initialize(code, body, headers={})
      @code, @body, @headers = code, body, headers
    end

    def [](header)
      @headers[header]
    end
  end
end
