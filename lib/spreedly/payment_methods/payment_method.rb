require 'time'

module Spreedly

  class PaymentMethod < Model

    field :email, :storage_state, :data

    attr_reader :errors

    def initialize(xml_doc)
      super
      initialize_errors(xml_doc)
    end

    def self.new_from(xml_doc)
      case xml_doc.at_xpath('.//payment_method_type').inner_text
      when 'credit_card'
        return CreditCard.new(xml_doc)
      when 'paypal'
        return Paypal.new(xml_doc)
      when 'sprel'
        return Sprel.new(xml_doc)
      end
    end

    def valid?
      @errors.empty?
    end

    private
    def initialize_errors(xml_doc)
      @errors = xml_doc.xpath(".//errors/error").map do |each|
        {
          attribute: each.attributes['attribute'].to_s,
          key: each.attributes['key'].to_s,
          message: each.text
        }
      end
    end

  end

end
