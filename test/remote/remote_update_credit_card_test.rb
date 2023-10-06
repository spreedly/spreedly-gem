require 'test_helper'

class RemoteUpdateCreditCardTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.update_credit_card("card_token", card_deets)
    end
  end

  def test_non_existent_card_token
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified payment method.") do
      @environment.update_credit_card('unknown_card', card_deets)
    end
  end

  def test_failed_with_validation_errors
    card = create_card_on(@environment)
    error = assert_raises(Spreedly::TransactionCreationError) do
      @environment.update_credit_card(card.token, card_deets(last_name: '', first_name: ' '))
    end

    expected_errors = [
      { attribute: "first_name", key: "errors.blank", message: "First name can't be blank" },
      { attribute: "last_name", key: "errors.blank", message: "Last name can't be blank" }
    ]

    assert_equal expected_errors, error.errors
    assert_equal "First name can't be blank\nLast name can't be blank", error.message
  end

  def test_successful_update_card
    card = create_card_on(@environment)
    result = @environment.update_credit_card(card.token, card_deets)

    assert_kind_of(Spreedly::CreditCard, result)
    assert_equal 'Cauthon', result.last_name
    assert_equal 'Mat', result.first_name
    assert_equal 'cauthon@wot.com', result.email
    assert_equal false, result.eligible_for_card_updater
  end

  def test_successfull_update_using_full_name
    card = create_card_on(@environment)
    result = @environment.update_credit_card(card.token, full_name: "Murray Rothbard")

    assert_equal "Murray", result.first_name
    assert_equal "Rothbard", result.last_name
    assert_equal "Murray Rothbard", result.full_name
  end

  private
  def card_deets(options = {})
    {
      email: 'cauthon@wot.com', month: 1, year: 2030,
      last_name: 'Cauthon', first_name: 'Mat',
      eligible_for_card_updater: 'false'
    }.merge(options)
  end

end
