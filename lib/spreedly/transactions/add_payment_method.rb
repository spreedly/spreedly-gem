module Spreedly

  class AddPaymentMethod < Transaction

    field :retained, type: :boolean

    attr_reader :payment_method

    def initialize(xml_doc)
      super
      payment_method_xml_doc = xml_doc.at_xpath('.//payment_method')
      @payment_method = payment_method_xml_doc ? PaymentMethod.new_from(payment_method_xml_doc) : nil
    end

  end

end
