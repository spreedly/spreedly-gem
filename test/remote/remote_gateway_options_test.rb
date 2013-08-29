require 'test_helper'

class RemoteGatewayOptionsTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_successfully_get_options
    gateway_classes = @environment.gateway_options
    braintree = gateway_classes.select { |each| each.name == "Braintree" }.first
    assert_equal "http://www.braintreepaymentsolutions.com/", braintree.homepage
    assert_equal ["credit_card", "third_party_token"], braintree.payment_methods
  end

end

