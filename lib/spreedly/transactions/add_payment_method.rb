module Spreedly

  class AddPaymentMethod < Transaction

    attr_reader :payment_method

    def initialize(parsed_response)
      super
      # @payment_method = PaymentMethod.new_from(parsed_response[:payment_method])
    end

  end

end
