require 'test_helper'
require 'unit/response_stubs/add_offsite_method_stubs'

class AddOffsiteMethodTest < Test::Unit::TestCase

  include AddOffsiteMethodStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_add_offsite_method
    t = add_offsite_method_using(successful_add_offsite_method_response)

    assert_kind_of(Spreedly::AddPaymentMethod, t)
    assert_kind_of(Spreedly::Sprel, t.payment_method)

    assert_equal 'offsite-transaction-token', t.token
    assert !t.retained?
    assert t.succeeded?
    assert_equal Time.parse("2013-08-02T18:04:45Z"), t.created_at
    assert_equal Time.parse("2013-08-02T18:04:45Z"), t.updated_at
    assert_equal 'Succeeded!', t.message

    assert_equal "offsite-payment-method-token", t.payment_method.token
    assert_equal "Just some payment method data here, no need to worry.", t.payment_method.data
  end

  def test_request_body_params
    body = get_request_body(successful_add_offsite_method_response) do
      @environment.add_offsite_method(full_offsite_details)
    end

    payment_method = body.xpath('./payment_method')
    assert_xpaths_in payment_method,
      [ './data', 'foo: bar' ],
      [ './email', 'me@joey.io' ],
      [ './retained', 'false' ]
  end

  private
  def add_offsite_method_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.add_offsite_method(ignored: "Because response is stubbed")
  end

  def full_offsite_details
    {
      email: 'me@joey.io',  data: "foo: bar", retained: false
    }
  end

end


