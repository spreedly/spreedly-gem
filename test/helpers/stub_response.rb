class StubResponse
  attr_reader :code, :body
  def self.succeeded(xml)
    StubResponse.new(200, xml)
  end

  def self.failed(xml)
    StubResponse.new(422, xml)
  end

  def initialize(code, body, headers={})
    @code, @body, @headers = code, body, headers
  end

  def [](header)
    @headers[header]
  end
end
