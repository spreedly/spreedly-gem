require 'test_helper'
require 'unit/response_stubs/find_transaction_stubs'

class FindTransactionTest < Test::Unit::TestCase

  include FindTransactionStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_find_transaction
    t = find_using(successful_get_transaction_response)

    assert_kind_of(Spreedly::AddPaymentMethod, t)
    assert_equal("2IFzBBh99rwjXKkZ0hkPVLjCBXL", t.token)
    assert_equal Time.parse("2013-08-05 19:32:49 UTC"), t.created_at
    assert_equal Time.parse("2013-08-05 19:32:49 UTC"), t.updated_at

    assert t.succeeded?
    assert_equal "Succeeded!", t.message
    assert_equal "7sqmBrh8zS4Mgei6wOyYskFpghF", t.payment_method.token
  end

  def test_transaction_with_no_response
    t = find_using(responseless_transaction_response)

    assert_kind_of(Spreedly::Purchase, t)
    assert_equal("1f41avmBKchYCNam8rMgrRRTppD", t.token)

    assert !t.succeeded?
    assert_nil t.response
  end

  private
  def find_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.find_transaction("IgnoredTokenSinceResponseIsStubbed")
  end

end
