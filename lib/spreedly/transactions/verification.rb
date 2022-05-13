module Spreedly

  class Verification < GatewayTransaction
    field :stored_credential_initiator, :stored_credential_reason_type
    attr_reader :payment_method

    def initialize(xml_doc)
      super
      @payment_method = PaymentMethod.new_from(xml_doc.at_xpath('.//payment_method'))
    end
  end

end
