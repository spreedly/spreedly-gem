require 'test_helper'
require 'unit/response_stubs/list_transactions_stubs'

class ListPaymentMethodTest < Test::Unit::TestCase

  include ListTransactionsStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_list_transactions
    list = list_using(successful_list_transactions_response)

    assert_kind_of(Array, list)
    assert_equal 2, list.size

    assert_equal 'TpjI3MSmLOSfqpFKP2poZRKc6Ru', list.first.gateway_token
    assert_equal '5Zkgibjs6z5R6XENMtZd8A8ajau', list.last.reference_token
    assert_kind_of Spreedly::Authorization, list.first
    assert_kind_of Spreedly::Capture, list.last

    assert_equal 'Aybara', list.first.payment_method.last_name
    assert_equal 'Successful capture', list.last.response.message
  end

  def test_request_url
    assert_request_url 'https://core.spreedly.com/v1/transactions.xml' do
      @environment.list_transactions
    end

    assert_request_url 'https://core.spreedly.com/v1/transactions.xml?since_token=SomeToken' do
      @environment.list_transactions("SomeToken")
    end

    assert_request_url 'https://core.spreedly.com/v1/payment_methods/SomePaymentMethodToken/transactions.xml' do
      @environment.list_transactions(nil, 'SomePaymentMethodToken')
    end

    assert_request_url 'https://core.spreedly.com/v1/payment_methods/SomePaymentMethodToken/transactions.xml?since_token=SinceToken' do
      @environment.list_transactions('SinceToken', 'SomePaymentMethodToken')
    end
  end

  private
  def list_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.list_transactions
  end

  def assert_request_url(expected_url)
    actual_url = get_request_url(successful_list_transactions_response) do
      yield
    end
    assert_equal expected_url, actual_url
  end

end
