require 'test_helper'
require 'unit/response_stubs/redact_payment_method_stubs'

class RedactPaymentMethodTest < Test::Unit::TestCase

  include RedactPaymentMethodStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_redact
    t = redact_using(successful_redact_response)

    assert_kind_of(Spreedly::RedactPaymentMethod, t)
    assert_equal '2BSe5T6FHpypph3ensF7m3Nb3qk', t.token
    assert_equal Time.parse('2013-08-05 17:43:41 UTC'), t.created_at
    assert_equal Time.parse('2013-08-05 17:43:41 UTC'), t.updated_at
    assert t.succeeded?
    assert_equal 'Succeeded!', t.message
    assert_equal 'succeeded', t.state
    assert_equal 'redacted', t.payment_method.storage_state
    assert_equal 'RvsxKgbAZBmiZHEPhhTcOQzJeC2', t.payment_method.token
  end

  def test_empty_request_body_params
    body = get_request_body(successful_redact_response) do
      @environment.redact_payment_method("TransactionToken")
    end

    assert_nil body.root
  end

  def test_request_body_params
    body = get_request_body(successful_redact_response) do
      @environment.redact_payment_method("TransactionToken", remove_from_gateway: 'ThePassedGatewayToken')
    end

    transaction = body.xpath('./transaction')
    assert_xpaths_in transaction,
      [ './remove_from_gateway', 'ThePassedGatewayToken' ]
  end

  private
  def redact_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.redact_payment_method("IgnoredTokenSinceResponseIsStubbed")
  end

end

