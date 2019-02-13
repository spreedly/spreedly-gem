require 'test_helper'
require 'unit/response_stubs/recache_payment_method_stubs'

class RecachePaymentMethodTest < Test::Unit::TestCase

  include RecachePaymentMethodStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_recache
    t = recache_using(successful_recache_payment_method_response)

    assert_kind_of(Spreedly::RecacheSensitiveData, t)
    assert_equal '2BSe5T6FHpypph3ensF7m3Nb3qk', t.token
    assert_equal Time.parse('2013-08-05 17:43:41 UTC'), t.created_at
    assert_equal Time.parse('2013-08-05 17:43:41 UTC'), t.updated_at
    assert t.succeeded?
    assert_equal 'Succeeded!', t.message
    assert_equal 'succeeded', t.state
    assert_equal 'retained', t.payment_method.storage_state
    assert_equal 'RvsxKgbAZBmiZHEPhhTcOQzJeC2', t.payment_method.token
  end

  private

  def recache_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.recache_payment_method("IgnoredTokenSinceResponseIsStubbed", verification_value: 'VerificationValue')
  end

end

