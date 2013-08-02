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

  private
  def add_card_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.add_credit_card(ignored: "Because response is stubbed")
  end

end


