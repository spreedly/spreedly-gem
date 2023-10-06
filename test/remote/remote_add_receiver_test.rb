require 'test_helper'

class RemoteAddReceiverTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
    @inactive_environment= Spreedly::Environment.new(inactive_environment_key, inactive_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.add_receiver(:test, 'http://api.example.com/post')
    end
  end

  def test_non_existent_receiver_type
    assert_raise_with_message(Spreedly::UnexpectedResponseError, "Failed with 403 Forbidden") do
      @environment.add_receiver(:non_existent, nil)
    end
  end

  # NOTE: if receiver type is Test, core skips hostname validation and default returns https://example.com
  # def test_add_test_receiver_sans_hostname
  #   assert_raise_with_message(Spreedly::TransactionCreationError, "Hostnames can't be blank") do
  #     @environment.add_receiver(:test, nil)
  #   end
  # end

  def test_add_test_receiver
    receiver = @environment.add_receiver(:test, 'http://spreedly-echo.herokuapp.com')
    assert_equal "test", receiver.receiver_type
    assert_equal 'https://www.example.com', receiver.hostnames
  end

  def test_need_active_account
    assert_raise_with_message(Spreedly::PaymentRequiredError, "Your environment (#{@inactive_environment.key}) has not been activated for real transactions with real payment methods. If you're using a Test Gateway you can *ONLY* use Test payment methods - ( https://docs.spreedly.com/reference/test-data). All other credit card numbers are considered real credit cards; real credit cards are not allowed when using a Test Gateway.") do
      @inactive_environment.add_receiver(:braintree)
    end
  end

end
