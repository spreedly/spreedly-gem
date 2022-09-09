require 'test_helper'

class RemoteAddGatewayTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.add_gateway(:test)
    end
  end

  def test_non_existent_gateway_type
    assert_raise_with_message(Spreedly::TransactionCreationError, "The gateway_type parameter is invalid.") do
      @environment.add_gateway(:non_existent)
    end
  end

  def test_add_test_gateway
    gateway = @environment.add_gateway(:test)
    assert_equal "test", gateway.gateway_type
    assert_equal "retained", gateway.state
    assert_equal "Spreedly Test", gateway.name
  end

  # 2022-09-08 There appears to no longer be a concept of a non-active environment. All environments are treated as production environments. There are only Test gateways that you can run test transactions against. 
  # def test_need_active_account
  #   assert_raise_with_message(Spreedly::PaymentRequiredError, "Your environment (" + remote_test_environment_key + ") has not been activated for real transactions with real payment methods. If you're using a Test Gateway you can *ONLY* use Test payment methods - ( https://docs.spreedly.com/test-data). All other credit card numbers are considered real credit cards; real credit cards are not allowed when using a Test Gateway.") do
  #     @environment.add_gateway(:wirecard)
  #   end
  # end

end
