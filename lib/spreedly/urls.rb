module Spreedly

  module Urls

    def base_url
      "https://core.spreedly.com"
    end

    def find_payment_method_url(token)
      "#{base_url}/v1/payment_methods/#{token}.xml"
    end

    def purchase_url(gateway_token)
      "#{base_url}/v1/gateways/#{gateway_token}/purchase.xml"
    end

    def authorize_url(gateway_token)
      "#{base_url}/v1/gateways/#{gateway_token}/authorize.xml"
    end

    def capture_url(authorization_token)
      "#{base_url}/v1/transactions/#{authorization_token}/capture.xml"
    end

    def add_payment_method_url
      "#{base_url}/v1/payment_methods.xml"
    end

    def retain_payment_method_url(payment_method_token)
      "#{base_url}/v1/payment_methods/#{payment_method_token}/retain.xml"
    end

    def redact_payment_method_url(payment_method_token)
      "#{base_url}/v1/payment_methods/#{payment_method_token}/redact.xml"
    end

    def add_gateway_url
      "#{base_url}/v1/gateways.xml"
    end

    def void_transaction_url(token)
      "#{base_url}/v1/transactions/#{token}/void.xml"
    end

    def refund_transaction_url(token)
      "#{base_url}/v1/transactions/#{token}/credit.xml"
    end

  end

end
