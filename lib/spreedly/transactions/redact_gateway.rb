module Spreedly

  class RedactGateway < Transaction

    attr_reader :gateway

    def initialize(xml_doc)
      super
      @gateway = Gateway.new(xml_doc.at_xpath('.//gateway'))
    end

  end

end
