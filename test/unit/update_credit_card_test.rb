require 'test_helper'
require 'unit/response_stubs/update_credit_card_stubs'

class UpdateCreditCreditCardTest < Test::Unit::TestCase

  include UpdateCreditCardStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_update_credit_card
    c = update_card_using(successful_update_credit_card_response)

    assert_kind_of(Spreedly::CreditCard, c)

    assert_equal 'LagdXxK2VXC6DQ5XxP6UdjRJXBn', c.token
    assert_equal 'Mat Cauthon', c.full_name
    assert_equal "Don't test everything here, since find_payment_method tests it all.", c.data
  end

  def test_request_body_params
    body = get_request_body(successful_update_credit_card_response) do
      @environment.update_credit_card('card_token', full_card_details)
    end

    payment_method = body.xpath('./payment_method')
    assert_xpaths_in payment_method,
      [ './data', 'talent: Late' ],
      [ './email', 'leavenworth@free.com' ],
      [ './first_name', 'Leavenworth' ],
      [ './last_name', 'Smedry' ],
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

  private
  def update_card_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.update_credit_card('card_token', ignored: "Because response is stubbed")
  end

  def full_card_details
    {
      email: 'leavenworth@free.com', month: 3, year: 2021,
      last_name: 'Smedry', first_name: 'Leavenworth', data: "talent: Late",
      address1: '10 Dragon Lane', address2: 'Suite 9', city: 'Tuki Tuki', state: 'Mokia',
      zip: '1122', country: 'Free Kingdoms', phone_number: '81Ab'
    }
  end

end


