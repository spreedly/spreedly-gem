require 'test_helper'

class RemoteGatewayOptionsTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_successfully_get_options
    gateway_classes = @environment.gateway_options
    braintree = gateway_classes.select { |each| each.name == "Braintree" }.first
    assert_equal "http://www.braintreepaymentsolutions.com/", braintree.homepage
    assert_equal %w(credit_card third_party_token), braintree.payment_methods
    assert_equal %w(asia_pacific europe north_america), braintree.regions
    assert_equal %w(orange blue), braintree.auth_modes.map { |e| e.auth_mode_type }
    assert_equal %w(login password), braintree.auth_modes.first.credentials.map { |e| e.name }
    assert_equal [ true, false ], braintree.auth_modes.first.credentials.map { |e| e.safe }
  end

end

