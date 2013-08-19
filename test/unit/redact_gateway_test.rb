require 'test_helper'
require 'unit/response_stubs/redact_gateway_stubs'

class RedactGatewayTest < Test::Unit::TestCase

  include RedactGatewayStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_redact
    t = redact_using(successful_redact_gateway_response)

    assert_kind_of(Spreedly::RedactGateway, t)
    assert_equal 'NXKt1iNkIJhzF5QCDt1qSsuFbcN', t.token
    assert_equal Time.parse('2013-08-19 17:16:07 UTC'), t.created_at
    assert_equal Time.parse('2013-08-19 17:16:07 UTC'), t.updated_at
    assert t.succeeded?
    assert_equal 'Succeeded!', t.message
    assert_equal '8zy49qcEUigjYbpPKCjlhDzUqJ', t.gateway.token
    assert_equal 'Spreedly Test', t.gateway.name
    assert_equal 'redacted', t.gateway.state
  end

  def test_empty_request_body_params
    body = get_request_body(successful_redact_gateway_response) do
      @environment.redact_gateway("TransactionToken")
    end

    assert_nil body.root
  end


  private
  def redact_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.redact_gateway("IgnoredTokenSinceResponseIsStubbed")
  end

end

