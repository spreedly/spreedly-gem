module Spreedly
  class Error < StandardError
  end

  class XmlErrorsList < Error
    attr_reader :errors
    include ErrorsParser

    def initialize(xml_doc)
      @errors = errors_from(xml_doc)
    end

    def message
      @errors.map { |each| each[:message] }.join("\n")
    end
  end

  class AuthenticationError < XmlErrorsList
  end

  class NotFoundError < XmlErrorsList
  end

  class TransactionCreationError < XmlErrorsList
  end

  class PaymentRequiredError < XmlErrorsList
  end

  class TimeoutError < Error
    def initialize(message = "The payment system is not responding.")
      super
    end
  end

  class UnexpectedResponseError < Error
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def to_s
      "Failed with #{response.code} #{response.message if response.respond_to?(:message)}"
    end
  end

end


