module Spreedly
  class AuthPurchase < GatewayTransaction
    field :currency_code, :checkout_url, :checkout_form, :redirect_url, :callback_url
    field :required_action, :challenge_form, :challenge_url, :device_fingerprint_form
    field :stored_credential_initiator, :stored_credential_reason_type, :three_ds_context
    field :amount, type: :integer

    attr_reader :payment_method

    def initialize(xml_doc)
      super
      @payment_method = PaymentMethod.new_from(xml_doc.at_xpath('.//payment_method'))
    end
  end
end
