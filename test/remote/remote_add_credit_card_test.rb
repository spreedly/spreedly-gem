require 'test_helper'

class RemoteAddCreditCardTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.add_credit_card(card_deets)
    end
  end

  def test_failed_with_validation_errors
    error = assert_raises(Spreedly::TransactionCreationError) do
      @environment.add_credit_card(card_deets(last_name: '', first_name: ' '))
    end

    expected_errors = [
      { attribute: "first_name", key: "errors.blank", message: "First name can't be blank" },
      { attribute: "last_name", key: "errors.blank", message: "Last name can't be blank" }
    ]

    assert_equal expected_errors, error.errors
    assert_equal "First name can't be blank\nLast name can't be blank", error.message
  end

  # 2022-09-08 There appears to no longer be a concept of a non-active environment. All environments are treated as production environments. There are only Test gateways that you can run test transactions against. 
  # def test_payment_required
  #   assert_raise_with_message(Spreedly::PaymentRequiredError, "Your environment (" + remote_test_environment_key + ") has not been activated for real transactions with real payment methods. If you're using a Test Gateway you can *ONLY* use Test payment methods - ( https://docs.spreedly.com/test-data). All other credit card numbers are considered real credit cards; real credit cards are not allowed when using a Test Gateway.") do
  #     @environment.add_credit_card(card_deets(number: '5474152271778594'))
  #   end
  # end

  def test_successful_add_card
    t = @environment.add_credit_card(card_deets)

    assert t.succeeded?
    assert_equal 'Aybara', t.payment_method.last_name
    assert !t.retained
    assert_equal 'cached', t.payment_method.storage_state
    assert_equal 'occupation: Blacksmith', t.payment_method.data
  end

  def test_successfully_retain_on_create
    t = @environment.add_credit_card(card_deets(retained: true))

    assert t.succeeded?
    assert t.retained
    assert_equal 'retained', t.payment_method.storage_state
  end

  def test_successfull_add_using_full_name
    t = @environment.add_credit_card(number: '5555555555554444', month: 1, year: 2023, full_name: "Kvothe Jones")
    assert t.succeeded?
    assert_equal "Kvothe", t.payment_method.first_name
    assert_equal "Jones", t.payment_method.last_name
    assert_equal "Kvothe Jones", t.payment_method.full_name
  end


  private
  def card_deets(options = {})
    {
      email: 'perrin@wot.com', number: '5555555555554444', month: 1, year: 2023,
      verification_value: '123',
      last_name: 'Aybara', first_name: 'Perrin', data: "occupation: Blacksmith"
    }.merge(options)
  end

end
