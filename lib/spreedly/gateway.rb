
module Spreedly

  class Gateway
    include Fields

    field :token, :gateway_type, :state, :name
    field :created_at, :updated_at, type: :date_time

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

  end

end
