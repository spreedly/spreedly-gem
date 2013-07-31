module Spreedly

  class Purchase < GatewayTransaction

    field :amount, :on_test_gateway, :currency_code
    attr_reader :payment_method

    def initialize(xml_doc)
      super
      @payment_method = PaymentMethod.new_from(xml_doc.at_xpath('.//payment_method'))
    end

    def amount
      @amount.to_i if @amount
    end

    def on_test_gateway
      "true" == @on_test_gateway
    end
    alias_method :on_test_gateway?, :on_test_gateway

  end

end
