module Spreedly

  class ResponseError < StandardError
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def to_s
      "Failed with #{response.code} #{response.message if response.respond_to?(:message)}"
    end
  end

end
