
module Spreedly

  class Transaction < Model

    field :state, :message
    field :succeeded, type: :boolean

    def self.new_from(xml_doc)
      case xml_doc.at_xpath('.//transaction_type').inner_text
      when 'AddPaymentMethod'
        return AddPaymentMethod.new(xml_doc)
      when 'Purchase'
        return Purchase.new(xml_doc)
      when 'Authorization'
        return Authorization.new(xml_doc)
      when 'Capture'
        return Capture.new(xml_doc)
      when 'Credit'
        return Refund.new(xml_doc)
      when 'Void'
        return Void.new(xml_doc)
      when 'Verification'
        return Verification.new(xml_doc)
      when 'RetainPaymentMethod'
        return RetainPaymentMethod.new(xml_doc)
      when 'RedactPaymentMethod'
        return RedactPaymentMethod.new(xml_doc)
      when 'RedactGateway'
        return RedactGateway.new(xml_doc)
      when 'RecacheSensitiveData'
        return RecacheSensitiveData.new(xml_doc)
      when 'DeliverPaymentMethod'
        return DeliverPaymentMethod.new(xml_doc)
      when 'Store'
        return Store.new(xml_doc)
      when 'GeneralCredit'
        return GeneralCredit.new(xml_doc)
      else
        Transaction.new(xml_doc)
      end
    end

    def self.new_list_from(xml_doc)
      transactions = xml_doc.xpath('.//transactions/transaction')
      transactions.map do |each|
        self.new_from(each)
      end
    end

  end

end
