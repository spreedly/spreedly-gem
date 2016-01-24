require 'test_helper'
require 'unit/response_stubs/find_payment_method_stubs'

class FindPaymentMethodTest < Test::Unit::TestCase

  include FindPaymentMethodStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_find_card
    card = find_using(successful_get_card_response)

    assert_kind_of(Spreedly::CreditCard, card)
    assert_equal("ROGJFe89QtbJL8QvjaJNMH0UG50", card.token)
    assert_equal("alcatraz@occulators.org", card.email)
    assert_equal("4445", card.last_four_digits)
    assert_equal("411111", card.first_six_digits)
    assert_equal('XXXX-XXXX-XXXX-4445', card.number)
    assert_equal("<some_attribute>5</some_attribute>", card.data)
    assert_equal(1369504152, card.created_at.to_i)
    assert_equal(1369508044, card.updated_at.to_i)
    assert_equal('master', card.card_type)
    assert_equal('credit_card', card.payment_method_type)
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
      { attribute: "first_name", key: "errors.blank", message: "First name can't be blank" },
      { attribute: "last_name", key: "errors.blank", message: "Last name can't be blank" },
      { attribute: "year", key: "errors.expired", message: "Year is expired" },
      { attribute: "year", key: "errors.invalid", message: "Year is invalid" },
      { attribute: "number", key: "errors.blank", message: "Number can't be blank" }
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

  def test_successfully_find_bank_account
    b = find_using(successful_get_bank_account_response)

    assert_kind_of(Spreedly::BankAccount, b)
    assert_equal "seeQDV0jwJwFa1FUUsph6kPMTj", b.token
    assert_equal "daniel@waterhouse.com", b.email
    assert_equal(1376673633, b.created_at.to_i)
    assert_equal(1376673633, b.updated_at.to_i)
    assert_equal("GeekyNote", b.data)
    assert_equal("cached", b.storage_state)
    assert_equal("Daniel", b.first_name)
    assert_equal("Waterhouse", b.last_name)
    assert_equal("Daniel Waterhouse", b.full_name)
    assert_equal("First Bank of Crypto", b.bank_name)
    assert_equal("checking", b.account_type)
    assert_equal("personal", b.account_holder_type)
    assert_equal("021", b.routing_number_display_digits)
    assert_equal("4321", b.account_number_display_digits)
    assert_equal("021*", b.routing_number)
    assert_equal("*4321", b.account_number)
    assert_equal([], b.errors)
  end

  private
  def find_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.find_payment_method("IgnoredTokenSinceResponseIsStubbed")
  end


end
