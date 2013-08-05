require 'test_helper'
require 'unit/response_stubs/retain_payment_method_stubs'

class RetainPaymentMethodTest < Test::Unit::TestCase

  include RetainPaymentMethodStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_retain
    t = retain_using(successful_retain_response)

    assert_kind_of(Spreedly::RetainPaymentMethod, t)
    assert_equal 'DsmkqsjRvqcMGSCBUUuUiRw8tso', t.token
    assert_equal Time.parse('2013-08-05 18:31:51 UTC'), t.created_at
    assert_equal Time.parse('2013-08-05 18:31:51 UTC'), t.updated_at
    assert t.succeeded?
    assert_equal 'Succeeded!', t.message
    assert_equal 'succeeded', t.state
    assert_equal 'retained', t.payment_method.storage_state
    assert_equal 'RXZDzDGxpqPV7v5ZNVO89n1qtTl', t.payment_method.token
  end

  def test_failed_retain
    t = retain_using(failed_retain_response)

    assert_kind_of(Spreedly::RetainPaymentMethod, t)
    assert_equal '2OLUmdUE7EFIdkb9tTnWyLPkxsF', t.token
    assert !t.succeeded?
    assert_equal 'failed', t.state

    assert_equal 'CpurR3zCfGcRC0tqwq9zp4zzIgf', t.payment_method.token
  end

  private
  def retain_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.retain_payment_method("IgnoredTokenSinceResponseIsStubbed")
  end

end

