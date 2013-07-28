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
    card = @environment.find_payment_method(@card_token)
    assert_kind_of(Spreedly::CreditCard, card)
    assert_equal("phil@example.com", card.email)
    assert_equal('XXXX-XXXX-XXXX-4444', card.number)
    assert_equal('201.344.7711', card.phone_number)
  end

  def test_find_valid_card
    card = @environment.find_payment_method(@card_token)
    assert card.valid?
    assert_equal({}, card.errors)
  end

  def test_find_invalid_card
    card = @environment.find_payment_method('CrY4e6wa3Jf4SMUZlvjFelW2YnQ')
    assert !card.valid?

    expected_errors = {
      first_name: { key: "errors.blank", text: "First name can't be blank" },
      last_name: { key: "errors.blank", text: "Last name can't be blank" },
      year: { key: "errors.invalid", text: "Year is invalid" },
      number: { key: "errors.blank", text: "Number can't be blank" }
    }

    assert_equal(expected_errors, card.errors)
  end

  def test_successfully_find_sprel
    sprel = @environment.find_payment_method("WZf8ZQgvmgOfdWaRtAzMLXPSQbk")
    assert_kind_of(Spreedly::Sprel, sprel)
    assert_equal "WZf8ZQgvmgOfdWaRtAzMLXPSQbk", sprel.token
    assert_equal "samuel@example.com", sprel.email
    assert_equal(1366981867, sprel.created_at.to_i)
    assert_equal(1366982301, sprel.updated_at.to_i)
    assert_equal("Some Pretty Data", sprel.data)
  end

  def test_successfully_find_paypal

  end

end
