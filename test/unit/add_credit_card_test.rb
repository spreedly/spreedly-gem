require 'test_helper'
require 'unit/response_stubs/add_credit_card_stubs'

class AddCreditCreditCardTest < Test::Unit::TestCase

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

    assert t.payment_method.eligible_for_card_updater
  end

  def test_request_body_params
    body = get_request_body(successful_add_credit_card_response) do
      @environment.add_credit_card(full_card_details)
    end

    payment_method = body.xpath('./payment_method')
    assert_xpaths_in payment_method,
      [ './data', 'talent: Late' ],
      [ './email', 'leavenworth@free.com' ],
      [ './retained', 'true' ]

    card = body.xpath('./payment_method/credit_card')
    assert_xpaths_in card,
      [ './first_name', 'Leavenworth' ],
      [ './last_name', 'Smedry' ],
      [ './number', '9555555555554444' ],
      [ './month', '3' ],
      [ './year', '2021' ],
      [ './address1', '10 Dragon Lane' ],
      [ './address2', 'Suite 9' ],
      [ './city', 'Tuki Tuki' ],
      [ './state', 'Mokia' ],
      [ './zip', '1122' ],
      [ './country', 'Free Kingdoms' ],
      [ './phone_number', '81Ab' ]
  end

  def test_successful_add_credit_card_without_fields_in_response
    t = add_card_using(successful_add_credit_card_partial_response)

    assert_kind_of(Spreedly::AddPaymentMethod, t)
    assert_kind_of(Spreedly::CreditCard, t.payment_method)

    assert_equal '6wxjN6HcDik8e3mAhBaaoVGSImH', t.token
    assert !t.retained?
    assert t.succeeded?
    assert_equal Time.parse("2013-08-02T18:04:45Z"), t.created_at
    assert_equal Time.parse("2013-08-02T18:04:45Z"), t.updated_at
    assert_equal 'Succeeded!', t.message

    assert_equal "AXaBXfVUqhaGMg8ytf8isiMAAL9", t.payment_method.token
    assert_equal "Don't test everything here, since find_payment_method tests it all.", t.payment_method.data

    assert_nil t.payment_method.full_name
    assert_nil t.payment_method.address1
    assert_nil t.payment_method.address2
    assert_nil t.payment_method.city
    assert_nil t.payment_method.state
    assert_nil t.payment_method.zip
    assert_nil t.payment_method.eligible_for_card_updater
  end

  def test_request_body_params_without_fields_in_response
    body = get_request_body(successful_add_credit_card_partial_response) do
      @environment.add_credit_card(full_card_details)
    end

    payment_method = body.xpath('./payment_method')
    assert_xpaths_in payment_method, [ './retained', 'true' ]

    card = body.xpath('./payment_method/credit_card')
    assert_xpaths_in card,
      [ './first_name', 'Leavenworth' ],
      [ './last_name', 'Smedry' ],
      [ './number', '9555555555554444' ],
      [ './month', '3' ],
      [ './year', '2021' ]

    assert_nil body.at_xpath('./payment_method/address1')
    assert_nil body.at_xpath('./payment_method/address2')
    assert_nil body.at_xpath('./payment_method/city')
    assert_nil body.at_xpath('./payment_method/state')
    assert_nil body.at_xpath('./payment_method/zip')
    assert_nil body.at_xpath('./payment_method/eligible_for_card_updater')
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


