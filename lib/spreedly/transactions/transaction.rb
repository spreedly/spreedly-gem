
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
      when 'Void'
        return Void.new(xml_doc)
      else
        Transaction.new(xml_doc)
      end
    end

  end

end
