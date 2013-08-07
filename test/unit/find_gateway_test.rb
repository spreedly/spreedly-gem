require 'test_helper'
require 'unit/response_stubs/find_gateway_stubs'

class FindGatewayTest < Test::Unit::TestCase

  include FindGatewayStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_find_gateway
    g = find_using(successful_get_gateway_response)

    assert_kind_of(Spreedly::Gateway, g)
    assert_equal("RsVlPgS4dMzeeUpKXxk01rMMRrQ", g.token)
    assert_equal Time.parse("2013-08-07 18:53:30 UTC"), g.created_at
    assert_equal Time.parse("2013-08-07 18:53:30 UTC"), g.updated_at
    assert_equal 'redacted', g.state
  end

  private
  def find_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.find_gateway("IgnoredTokenSinceResponseIsStubbed")
  end

end
