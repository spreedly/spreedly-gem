require 'test_helper'

class RemoteRecacheSensitiveDataTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_recache_failed_verification_value
    card = create_card_on(@environment)
    result = @environment.recache_sensitive_data(card.token, wrong_test_data)

    assert_kind_of(Spreedly::RecacheSensitiveData, result)
    assert_equal true, result.succeeded
    assert_equal '', result.payment_method.verification_value
  end

  def test_recache_successful_verification_value
    card = create_card_on(@environment)
    result = @environment.recache_sensitive_data(card.token, test_data)

    assert_kind_of(Spreedly::RecacheSensitiveData, result)
    assert_equal true, result.succeeded
    assert_equal 'XXX', result.payment_method.verification_value
  end

  private
  def test_data(options = {})
    {
      credit_card: {
        verification_value: 123
      }
    }.merge(options)
  end

  def wrong_test_data(options = {})
    {
      credit_card: {
        wrong_key_for_verification_value: 123
      }
    }.merge(options)
  end

end
