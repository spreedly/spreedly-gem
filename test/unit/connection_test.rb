require 'test_helper'

class ConnectionTest < Test::Unit::TestCase

  def setup
    @endpoint   = 'https://example.com/it.xml'
    @connection = Spreedly::Connection.new(@endpoint)
  end


end
