module Spreedly

  class DeliverPaymentMethod < Transaction

    attr_reader :response
    attr_reader :payment_method, :receiver
    field :succeeded, type: :boolean

    def initialize(xml_doc)
      super
      @payment_method = PaymentMethod.new_from(xml_doc.at_xpath('.//payment_method'))
      @receiver = Receiver.new(xml_doc.at_xpath('.//receiver'))

      response_xml_doc = xml_doc.at_xpath('.//response')
      @response = response_xml_doc ? DeliverPaymentResponse.new(response_xml_doc) : nil
    end

  end

  class DeliverPaymentResponse
    include Fields

    field :status, :headers, :body

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

  end

end
