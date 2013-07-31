
module Spreedly

  class Gateway
    include Fields

    field :token, :created_at, :updated_at, :gateway_type, :state, :name

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

    def created_at
      Time.parse(@created_at) if @created_at
    end

    def updated_at
      Time.parse(@updated_at) if @updated_at
    end

  end

end
