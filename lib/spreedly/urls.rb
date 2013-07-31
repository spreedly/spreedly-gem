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

    def add_payment_method_url
      "#{base_url}/v1/payment_methods.xml"
    end

  end

end
