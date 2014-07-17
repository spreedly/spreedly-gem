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

  def test_add_test_receiver_sans_hostname
    assert_raise_with_message(Spreedly::TransactionCreationError, "Hostnames can't be blank") do
      @environment.add_receiver(:test, nil)
    end
  end

  def test_add_test_receiver
    receiver = @environment.add_receiver(:test, 'http://api.example.com/post')
    assert_equal "test", receiver.receiver_type
    assert_equal 'http://api.example.com/post', receiver.hostnames
  end

  # Coming soon
  # def test_need_active_account
  #   assert_raise_with_message(Spreedly::PaymentRequiredError, "Your account has not been activated for real transactions. Please update your subscription settings.") do
  #     @environment.add_receiver(:braintree)
  #   end
  # end

end
