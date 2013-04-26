require 'time'

module Spreedly

  class PaymentMethod
    include Fields

    field :token, :email, :data, :created_at, :updated_at

    def initialize(parsed_response)
      initialize_fields(parsed_response)
    end

    def created_at
      Time.parse(@created_at) if @created_at
    end

    def updated_at
      Time.parse(@updated_at) if @updated_at
    end
  end

end
