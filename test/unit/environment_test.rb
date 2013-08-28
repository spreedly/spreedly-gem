require 'test_helper'

class EnvironmentTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new("TheKey", "TheAccessSecret")
  end

  def test_currency_code_defaults_to_usd
    assert_equal "USD", @environment.currency_code
  end

  def test_currency_code_can_be_overridden
    environment = Spreedly::Environment.new("TheKey", "TheAccessSecret", currency_code: "EUR")
    assert_equal "EUR", environment.currency_code
  end

  def test_base_url_default
    assert_equal "https://core.spreedly.com", @environment.base_url
  end

  def test_base_url_override
    environment = Spreedly::Environment.new("TheKey", "TheAccessSecret", base_url: "http://it.com")
    assert_equal "http://it.com", environment.base_url
  end
end
