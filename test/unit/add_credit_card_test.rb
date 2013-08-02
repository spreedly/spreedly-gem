require 'test_helper'
require 'unit/response_stubs/add_credit_card_stubs'

class AddGatewayTest < Test::Unit::TestCase

  include AddCreditCardStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_add_credit_card
    t = add_card_using(successful_add_credit_card_response)

    assert_kind_of(Spreedly::AddPaymentMethod, t)
    assert_kind_of(Spreedly::CreditCard, t.payment_method)

    assert_equal '6wxjN6HcDik8e3mAhBaaoVGSImH', t.token
    assert !t.retained?
    assert t.succeeded?
    assert_equal Time.parse("2013-08-02T18:04:45Z"), t.created_at
    assert_equal Time.parse("2013-08-02T18:04:45Z"), t.updated_at
    assert_equal 'Succeeded!', t.message

    assert_equal "AXaBXfVUqhaGMg8ytf8isiMAAL9", t.payment_method.token
    assert_equal "Eland Venture", t.payment_method.full_name
    assert_equal "Don't test everything here, since find_payment_method tests it all.", t.payment_method.data
  end

  def test_all_options_get_sent
    body = get_request_body(successful_add_credit_card_response) do
      @environment.add_credit_card(full_card_details)
    end

    assert_equal 'talent: Late', body.xpath('//payment_method//data').text
    assert_equal 'leavenworth@free.com', body.xpath('//payment_method//email').text
    assert_equal 'true', body.xpath('//payment_method//retained').text

    card = body.xpath('//payment_method/credit_card')
    assert_equal 'Leavenworth', card.xpath('./first_name').text
    assert_equal 'Smedry', card.xpath('./last_name').text
    assert_equal '9555555555554444', card.xpath('./number').text
    assert_equal '3', card.xpath('./month').text
    assert_equal '2021', card.xpath('./year').text
    assert_equal '10 Dragon Lane', card.xpath('./address1').text
    assert_equal 'Suite 9', card.xpath('./address2').text
    assert_equal 'Tuki Tuki', card.xpath('./city').text
    assert_equal 'Mokia', card.xpath('./state').text
    assert_equal '1122', card.xpath('./zip').text
    assert_equal 'Free Kingdoms', card.xpath('./country').text
    assert_equal '81Ab', card.xpath('./phone_number').text
  end

  private
  def add_card_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.add_credit_card(ignored: "Because response is stubbed")
  end

  def full_card_details
    {
      email: 'leavenworth@free.com', number: '9555555555554444', month: 3, year: 2021,
      last_name: 'Smedry', first_name: 'Leavenworth', data: "talent: Late",
      address1: '10 Dragon Lane', address2: 'Suite 9', city: 'Tuki Tuki', state: 'Mokia',
      zip: '1122', country: 'Free Kingdoms', phone_number: '81Ab', retained: true
    }
  end

end


