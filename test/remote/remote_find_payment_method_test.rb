require 'test_helper'

class RemoteFindPaymentMethodTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new("R7lHscqcYkZeDGGbthKp6GKMu15", "8sefxO5Q44sLWpmZpalQS3Qlqo03JbCemsqsWJR3YOLCuigOFRlaLSAn0WaL5dWU")
    @card_token = "FOGJFe88QtbJL7QvjaJNMH0UG50"
  end

  def test_invalid_login
    environment = Spreedly::Environment.new("UnknownEnvironmentKey", "UnknownAccessSecret")
    error = assert_raises(Spreedly::AuthenticationError) do
      environment.find_payment_method(@card_token)
    end

    assert_equal "Unable to authenticate using the given access_token.", error.message
  end

  def test_payment_method_not_found
    error = assert_raises(Spreedly::NotFoundError) do
      @environment.find_payment_method("SomeUnknownToken")
    end

    assert_equal "Unable to find the specified payment method.", error.message
  end

  def test_successfully_find_card
    found = @environment.find_payment_method(create_card.token)
    assert_kind_of(Spreedly::CreditCard, found)
    assert_equal("perrin@wot.com", found.email)
    assert_equal('XXXX-XXXX-XXXX-4444', found.number)
    assert_equal('Aybara', found.last_name)
  end


  def test_successfully_find_paypal

  end

  private
  def credit_card_deets
    {
      email: 'perrin@wot.com', number: '5555555555554444', month: 1, year: 2019,
      last_name: 'Aybara', first_name: 'Perrin', retained: true
    }
  end

  def create_card
    @environment.create_credit_card(credit_card_deets).payment_method
  end
end
