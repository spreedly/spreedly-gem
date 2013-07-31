
module Spreedly

  class Transaction
    include Fields

    field :token, :created_at, :updated_at, :succeeded
    field :message

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

    def self.new_from(xml_doc)
      case xml_doc.at_xpath('//transaction_type').inner_text
      when 'AddPaymentMethod'
        return AddPaymentMethod.new(xml_doc)
      else
        Transaction.new(xml_doc)
      end
    end

    def created_at
      Time.parse(@created_at) if @created_at
    end

    def updated_at
      Time.parse(@updated_at) if @updated_at
    end

    def succeeded?
      "true" == succeeded
    end

  end

end
