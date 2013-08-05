module Spreedly

  class Capture < GatewayTransaction

    field :currency_code, :reference_token
    field :amount, type: :integer

    def initialize(xml_doc)
      super
    end

  end

end
