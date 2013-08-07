require 'test_helper'

class RemoteFindPaymentMethodTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.find_payment_method("SomeToken")
    end
  end

  def test_payment_method_not_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified payment method.") do
       @environment.find_payment_method("SomeUnknownToken")
    end
  end

  def test_successfully_find_card
    found = @environment.find_payment_method(create_card_on(@environment).token)
    assert_kind_of(Spreedly::CreditCard, found)
    assert_equal("perrin@wot.com", found.email)
    assert_equal('XXXX-XXXX-XXXX-4444', found.number)
    assert_equal('Aybara', found.last_name)
  end

end
