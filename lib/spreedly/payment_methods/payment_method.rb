require 'time'

module Spreedly

  class PaymentMethod < Model

    include ErrorsParser

    field :email, :storage_state, :data, :payment_method_type
    attr_reader :errors

    def initialize(xml_doc)
      super
      @errors = errors_from(xml_doc)
    end

    def self.new_from(xml_doc)
      case xml_doc.at_xpath('.//payment_method_type').inner_text
      when 'credit_card'
        return CreditCard.new(xml_doc)
      when 'paypal'
        return Paypal.new(xml_doc)
      when 'sprel'
        return Sprel.new(xml_doc)
      when 'bank_account'
        return BankAccount.new(xml_doc)
      when 'third_party_token'
        return ThirdPartyToken.new(xml_doc)
      when 'google_pay'
        return GooglePay.new(xml_doc)
      when 'apple_pay'
        return ApplePay.new(xml_doc)
      end
    end

    def self.new_list_from(xml_doc)
      payment_methods = xml_doc.xpath('.//payment_methods/payment_method')
      payment_methods.map do |each|
        self.new_from(each)
      end
    end

    def valid?
      @errors.empty?
    end

  end

end
