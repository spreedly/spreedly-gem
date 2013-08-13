require 'test_helper'
require 'unit/response_stubs/list_payment_methods_stubs'

class ListPaymentMethodsTest < Test::Unit::TestCase

  include ListPaymentMethodsStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_list_payment_methods
    list = list_using(successful_list_payment_methods_response)

    assert_kind_of(Array, list)
    assert_equal 2, list.size

    assert_equal 'Perrin Aybara', list.first.full_name
    assert_equal 'Mat Cauthon', list.last.full_name
    assert_kind_of Spreedly::CreditCard, list.first
    assert_kind_of Spreedly::CreditCard, list.last
  end

  def test_request_url
    assert_request_url 'https://core.spreedly.com/v1/payment_methods.xml' do
      @environment.list_payment_methods
    end

    assert_request_url 'https://core.spreedly.com/v1/payment_methods.xml?since_token=SomeToken' do
      @environment.list_payment_methods("SomeToken")
    end
  end

  private
  def list_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.list_payment_methods
  end

  def assert_request_url(expected_url)
    actual_url = get_request_url(successful_list_payment_methods_response) do
      yield
    end
    assert_equal expected_url, actual_url
  end

end
