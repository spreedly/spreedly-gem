require 'test_helper'
require 'unit/response_stubs/list_supported_receivers_stubs'

class ListSupportedReceiversTest < Test::Unit::TestCase

  include ListSupportedReceiversStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_list_supported_receivers
    list = list_using(successful_list_supported_receivers_response)

    assert_kind_of(Array, list)
    assert_equal 2, list.size

    assert_equal 'Example Production', list.first.name
    assert_equal 'Example Sandbox', list.last.name
    assert_kind_of Spreedly::SupportedReceiver, list.first
    assert_kind_of Spreedly::SupportedReceiver, list.last
  end

  def test_request_url
    assert_request_url 'https://core.spreedly.com/v1/receivers_options.xml' do
      @environment.list_supported_receivers
    end
  end

  private
  def list_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.list_supported_receivers
  end

  def assert_request_url(expected_url)
    actual_url = get_request_url(successful_list_supported_receivers_response) do
      yield
    end
    assert_equal expected_url, actual_url
  end
end
