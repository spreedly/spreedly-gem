module Spreedly

  class AuthPurchase < GatewayTransaction

    field :currency_code, :gateway_transaction_id
    field :amount, type: :integer

    attr_reader :payment_method

    def initialize(xml_doc)
      super
      @payment_method = PaymentMethod.new_from(xml_doc.at_xpath('.//payment_method'))
    end

  end

end
