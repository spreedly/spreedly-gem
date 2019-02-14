require 'test_helper'

class RemoteRedactReceiverTest < Test::Unit::TestCase
  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_successful_redact
    receiver = @environment.add_receiver(:test, 'https://sandbox.usaepay.com')

    transaction = @environment.redact_receiver(receiver.token)

    assert transaction.succeeded?
    assert_equal 'redacted', transaction.state
  end
end
