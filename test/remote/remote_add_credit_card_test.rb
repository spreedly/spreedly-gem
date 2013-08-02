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


  private
  def card_deets(options = {})
    {
      email: 'perrin@wot.com', number: '5555555555554444', month: 1, year: 2019,
      last_name: 'Aybara', first_name: 'Perrin', data: "occupation: Blacksmith"
    }.merge(options)
  end

end
