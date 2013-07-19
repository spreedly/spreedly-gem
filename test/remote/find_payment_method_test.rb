require 'test_helper'

class FindPaymentMethodTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new("R7lHscqcYkZeDGGbthKp6GKMu15", "8sefxO5Q44sLWpmZpalQS3Qlqo03JbCemsqsWJR3YOLCuigOFRlaLSAn0WaL5dWU")
    @card_token = "FOGJFe88QtbJL7QvjaJNMH0UG50"
  end

  def test_invalid_login
    environment = Spreedly::Environment.new("UnknownEnvironmentKey", "UnknownAccessSecret")
    error = assert_raises(Spreedly::ResponseError) do
      environment.find_payment_method(@card_token)
    end

    assert_equal "401", error.response.code
    assert_equal "Failed with 401 Unauthorized", error.message
  end

  def test_payment_method_not_found
    error = assert_raises(Spreedly::ResponseError) do
      @environment.find_payment_method("SomeUnknownToken")
    end

    assert_equal "404", error.response.code
    assert_equal "Failed with 404 Not Found", error.message
  end

  def test_successfully_find_card
    card = @environment.find_payment_method(@card_token)
    assert_kind_of(Spreedly::CreditCard, card)
    assert_equal(@card_token, card.token)
    assert_equal("phil@example.com", card.email)
    assert_equal("4444", card.last_four_digits)
    assert_equal('XXXX-XXXX-XXXX-4444', card.number)
    assert_equal("<how_many>3</how_many>", card.data)
    assert_equal(1366912152, card.created_at.to_i)
    assert_equal(1366916044, card.updated_at.to_i)
    assert_equal('master', card.card_type)
    assert_equal('Phillip', card.first_name)
    assert_equal('Jones', card.last_name)
    assert_equal('9', card.month)
    assert_equal('2019', card.year)
    assert_equal('123 Main Street', card.address1)
    assert_equal('Apt. 2', card.address2)
    assert_equal('Wanaque', card.city)
    assert_equal('NJ', card.state)
    assert_equal('USA', card.country)
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
      'first_name' => { key: "errors.blank", text: "First name can't be blank" },
      'last_name' => { key: "errors.blank", text: "Last name can't be blank" },
      'year' => { key: "errors.invalid", text: "Year is invalid" }
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

end
