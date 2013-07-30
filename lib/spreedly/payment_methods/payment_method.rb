require 'time'

module Spreedly

  class PaymentMethod
    include Fields

    field :token, :email, :data, :created_at, :updated_at
    attr_reader :errors


    def initialize(parsed_response)
      initialize_fields(parsed_response)
      initialize_errors(parsed_response[:errors])
    end

    def self.new_from(parsed_response)
      case parsed_response[:payment_method_type]
      when 'credit_card'
        return CreditCard.new(parsed_response)
      when 'sprel'
        return Sprel.new(parsed_response)
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
    def initialize_errors(errors_xml)
      @errors = {}
      doc = Nokogiri::XML("<errors>#{errors_xml}</errors>")
      doc.xpath("//errors/error").each do |each|
        @errors[each.attributes['attribute'].to_s.to_sym] = {
          key: each.attributes['key'].to_s,
          text: each.text
        }
      end
    end

  end

end
