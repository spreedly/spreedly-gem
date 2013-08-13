require 'test_helper'

class RemoteListPaymentMethodsTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.list_payment_methods
    end
  end

  def test_successfully_list_payment_methods
    c1 = create_card_on(@environment).token
    c2 = create_card_on(@environment).token
    c3 = create_card_on(@environment).token

    first_twenty = @environment.list_payment_methods
    assert_equal 20, first_twenty.size
    assert_kind_of Spreedly::Model, first_twenty.first

    payment_methods = @environment.list_payment_methods(c1)
    assert_equal 2, payment_methods.size
    assert_kind_of(Spreedly::CreditCard, payment_methods.first)
    assert_kind_of(Spreedly::CreditCard, payment_methods.last)

    assert_equal c2, payment_methods.first.token
    assert_equal c3, payment_methods.last.token
  end

end

