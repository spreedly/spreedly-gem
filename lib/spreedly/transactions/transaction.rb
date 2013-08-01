
module Spreedly

  class Transaction
    include Fields

    field :token, :state, :message
    field :created_at, :updated_at, type: :date_time
    field :succeeded, type: :boolean

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

    def self.new_from(xml_doc)
      case xml_doc.at_xpath('.//transaction_type').inner_text
      when 'AddPaymentMethod'
        return AddPaymentMethod.new(xml_doc)
      when 'Purchase'
        return Purchase.new(xml_doc)
      else
        Transaction.new(xml_doc)
      end
    end

  end

end
