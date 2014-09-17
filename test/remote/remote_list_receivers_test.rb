require 'test_helper'

class RemoteListReceiversTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_successfully_list_receivers
    r1 = @environment.add_receiver(:test, 'http://loloeffect.com/test').token
    r2 = @environment.add_receiver(:test, 'http://posttestserver.com/post.php').token
    r3 = @environment.add_receiver(:test, 'http://api.example.com/post').token

    first_twenty = @environment.list_receivers
    assert_equal 20, first_twenty.size
    assert_kind_of Spreedly::Model, first_twenty.first

    receivers = @environment.list_receivers(r1)
    assert_equal 2, receivers.size
    assert_kind_of(Spreedly::Receiver, receivers.first)
    assert_kind_of(Spreedly::Receiver, receivers.last)

    assert_equal r2, receivers.first.token
    assert_equal r3, receivers.last.token
  end

end
