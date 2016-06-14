require 'test_helper'

class RemoteReceiverOptionsTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_successfully_get_options
    receiver_classes = @environment.receiver_options
    ace = receiver_classes.select { |each| each.name == "Acerentacar Receiver" }.first
    assert_equal "https://ota.acerentacar.com", ace.hostnames
    assert_equal "Ace Rent a Car", ace.company_name
    assert_equal "ace_rent_a_car_receiver", ace.receiver_type
  end

end

