module Spreedly

  class DeliverPaymentMethod < Transaction

    attr_reader :response
    field :succeeded, type: :boolean

    def initialize(xml_doc)
      super
      response_xml_doc = xml_doc.at_xpath('.//response')
      @response = response_xml_doc ? DPMResponse.new(response_xml_doc) : nil
    end

  end

  class DPMResponse
    include Fields

    field :status, :headers, :body

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

  end

end
