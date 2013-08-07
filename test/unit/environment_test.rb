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

end
