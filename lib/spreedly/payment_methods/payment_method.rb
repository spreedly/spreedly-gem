require 'time'

module Spreedly

  class PaymentMethod
    include Fields

    field :token, :email, :created_at, :updated_at, :storage_state, :data
    attr_reader :errors

    def initialize(xml_doc)
      initialize_fields(xml_doc)
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

    def created_at
      Time.parse(@created_at) if @created_at
    end

    def updated_at
      Time.parse(@updated_at) if @updated_at
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
          text: each.text
        }
      end
    end

  end

end
