module Spreedly

  class Store < Transaction

    attr_reader :payment_method, :basis_payment_method, :response

    def initialize(xml_doc)
      super
      payment_method_xml_doc = xml_doc.at_xpath('.//payment_method')
      @payment_method = payment_method_xml_doc ? PaymentMethod.new_from(xml_doc.at_xpath('.//payment_method')) : nil

      @basis_payment_method = PaymentMethod.new_from(xml_doc.at_xpath('.//basis_payment_method'))

      response_xml_doc = xml_doc.at_xpath('.//response')
      @response = response_xml_doc ? Response.new(response_xml_doc) : nil
    end

  end

end
