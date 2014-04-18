require 'test_helper'
require 'unit/response_stubs/find_transcript_stubs'

class FindTranscriptTest < Test::Unit::TestCase

  include FindTranscriptStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_successful_find_transcript
    t = find_using(successful_get_transcript_response)

    assert_kind_of(String, t)
  end

  private
  def find_using(response)
    @environment.stubs(:raw_ssl_request).returns(response)
    @environment.find_transcript("IgnoredTokenSinceResponseIsStubbed")
  end

end
