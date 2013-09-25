require 'test_helper'

class FindTransactionTranscriptTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_find_transcript
    t = find_using("Some Non XML String.  Could be anything really.")
    assert_equal "Some Non XML String.  Could be anything really.", t
  end

  private
  def find_using(response)
    @environment.stubs(:raw_ssl_request).returns(StubResponse.succeeded(response))
    @environment.find_transcript("IgnoredTokenSinceResponseIsStubbed")
  end

end
