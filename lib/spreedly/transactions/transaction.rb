
module Spreedly

  class Transaction
    include Fields

    field :created_at, :updated_at, :succeeded
    field :message

    def initialize(parsed_response)
      initialize_fields(parsed_response)
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
