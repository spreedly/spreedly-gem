
require 'test_helper'

class RemoteListGatewaysTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.list_gateways
    end
  end

  def test_successfully_list_gateways
    g1 = @environment.add_gateway(:test).token
    sleep 1
    g2 = @environment.add_gateway(:test).token
    sleep 1
    g3 = @environment.add_gateway(:test).token

    first_twenty = @environment.list_gateways
    assert_equal 20, first_twenty.size
    assert_kind_of Spreedly::Model, first_twenty.first

    gateways = @environment.list_gateways(g1)
    p gateways
    p g2
    p g3
    assert_equal 2, gateways.size
    assert_kind_of(Spreedly::Gateway, gateways.first)
    assert_kind_of(Spreedly::Gateway, gateways.last)

    assert_equal g2, gateways.first.token
    assert_equal g3, gateways.last.token
  end

end

