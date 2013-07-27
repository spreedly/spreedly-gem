module Spreedly
  class Error < StandardError
  end

  class AuthenticationError < Error
    def initialize(message = "Unable to authenticate using the given access_token.")
      super
    end
  end

  class NotFoundError < Error
    def initialize(message = "Unable to authenticate using the given access_token.")
      super
    end
  end

  class ResponseError < Error
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def to_s
      "Failed with #{response.code} #{response.message if response.respond_to?(:message)}"
    end
  end

end

