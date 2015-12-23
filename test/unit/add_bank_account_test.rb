require 'test_helper'
require 'unit/response_stubs/add_bank_account_stubs'

class AddBankAccountTest < Test::Unit::TestCase

  include AddBankAccountStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_add_bank_account
    t = add_bank_account_using(successful_add_bank_account_response)

    assert_kind_of(Spreedly::AddPaymentMethod, t)
    assert_kind_of(Spreedly::BankAccount, t.payment_method)

    assert !t.retained?
    assert t.succeeded?
  end

  private
  def add_bank_account_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.add_bank_account(ignored: "Because response is stubbed")
  end
end
