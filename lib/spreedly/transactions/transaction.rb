
module Spreedly

  class Transaction
    include Fields

    field :token, :created_at, :updated_at, :succeeded
    field :message

    def initialize(parsed_response)
      initialize_fields(parsed_response)
    end

    def self.new_from(parsed_response)
      case parsed_response[:transaction_type]
      when 'AddPaymentMethod'
        return AddPaymentMethod.new(parsed_response)
      else
        Transaction.new(parsed_response)
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
