require 'test_helper'
require 'unit/response_stubs/find_transaction_transcript_stubs'

class FindTransactionTranscriptTest < Test::Unit::TestCase

  include FindTransactionTranscriptStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_find_transaction_transcript
    t = find_using(successful_get_transaction_transcript_response)

    assert_kind_of(String, t)
  end

  private
  def find_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.find_transaction_transcript("IgnoredTokenSinceResponseIsStubbed")
  end

end
