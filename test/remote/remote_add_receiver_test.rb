require 'test_helper'

class RemoteAddReceiverTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
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

  # 2022-09-08 host names are no longer required for test receivers, and are ignored for production receivers
  # def test_add_test_receiver_sans_hostname
  #   assert_raise_with_message(Spreedly::TransactionCreationError, "Hostnames can't be blank") do
  #     @environment.add_receiver(:test, nil)
  #   end
  # end

  def test_add_test_receiver
    receiver = @environment.add_receiver(:test, 'http://spreedly-echo.herokuapp.com')
    assert_equal "test", receiver.receiver_type
    assert_equal 'http://spreedly-echo.herokuapp.com', receiver.hostnames
  end

  # 2022-09-08 There appears to no longer be a concept of a non-active environment. All environments are treated as production environments. There are only Test gateways that you can run test transactions against. 
  # def test_need_active_account
  #   assert_raise_with_message(Spreedly::PaymentRequiredError, "Your environment (R7lHscqcYkZeDGGbthKp6GKMu15) has not been activated for real transactions with real payment methods. If you're using a Test Gateway you can *ONLY* use Test payment methods - ( https://docs.spreedly.com/test-data). All other credit card numbers are considered real credit cards; real credit cards are not allowed when using a Test Gateway.") do
  #     @environment.add_receiver(:braintree)
  #   end
  # end

end
