require 'test_helper'

class RemoteCompleteTransactionTest < Test::Unit::TestCase
  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_successful_complete_a_3ds_transaction
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_threeds_2_card_on(@environment).token
    base64_encoded_browser_info = "eyJ3aWR0aCI6MTY4MCwiaGVpZ2h0IjoxMDUwLCJkZXB0aCI6MjQsInRpbWV6b25lIjoyNDAsInVzZXJfYWdlbnQiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNF80KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTIuMSBTYWZhcmkvNjA1LjEuMTUiLCJqYXZhIjp0cnVlLCJsYW5ndWFnZSI6ImVuLVVTIn0="
    purchase = @environment.purchase_on_gateway(
      gateway_token,
      card_token,
      3003,
      browser_info: base64_encoded_browser_info,
      three_ds_version: '2.0',
      redirect_url: 'https://example.com/redirect',
      callback_url: 'https://example.com/callback',
      attempt_3dsecure: true
    )
    assert_equal 'pending', purchase.state

    complete_transaction = @environment.complete_transaction(purchase.token)
    assert_equal 'succeeded', complete_transaction.state
  end
end
