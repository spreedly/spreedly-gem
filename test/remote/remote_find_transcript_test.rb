require 'test_helper'

class RemoteFindTranscriptTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.find_transcript("SomeToken")
    end
  end

  def test_transaction_not_found
    assert_raise(Spreedly::NotFoundError) do
       @environment.find_transcript("SomeUnknownToken")
    end
  end

  def test_successfully_find_transcript
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_failed_card_on(@environment).token
    transaction = @environment.purchase_on_gateway(gateway_token, card_token, 144)

    found = @environment.find_transcript(transaction.token)
    assert_kind_of(String, found)
  end

end
