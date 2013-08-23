require 'test_helper'
require 'unit/response_stubs/list_gateways_stubs'

class ListGatewaysTest < Test::Unit::TestCase

  include ListGatewaysStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_list_payment_methods
    list = list_using(successful_list_gateways_response)

    assert_kind_of(Array, list)
    assert_equal 2, list.size

    assert_equal 'OJUFe5ZR6pFfL4i4ZGVmvGWkZUY', list.first.token
    assert_equal '52wqOssuKZSXEYde30AGTG6xl8v', list.last.token
    assert_kind_of Spreedly::Gateway, list.first
    assert_kind_of Spreedly::Gateway, list.last
  end

  def test_request_url
    assert_request_url 'https://core.spreedly.com/v1/gateways.xml' do
      @environment.list_gateways
    end

    assert_request_url 'https://core.spreedly.com/v1/gateways.xml?since_token=SomeToken' do
      @environment.list_gateways("SomeToken")
    end
  end

  private
  def list_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.list_gateways
  end

  def assert_request_url(expected_url)
    actual_url = get_request_url(successful_list_gateways_response) do
      yield
    end
    assert_equal expected_url, actual_url
  end

end
