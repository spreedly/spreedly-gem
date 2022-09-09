module Spreedly
  module Urls
    def find_payment_method_url(token)
      "#{base_url}/v1/payment_methods/#{token}.xml"
    end

    def find_transaction_url(token)
      "#{base_url}/v1/transactions/#{token}.xml"
    end

    def find_transcript_url(transaction_token)
      "#{base_url}/v1/transactions/#{transaction_token}/transcript"
    end

    def complete_transaction_url(token)
      "#{base_url}/v1/transactions/#{token}/complete.xml"
    end

    def find_gateway_url(token)
      "#{base_url}/v1/gateways/#{token}.xml"
    end

    def purchase_url(gateway_token)
      "#{base_url}/v1/gateways/#{gateway_token}/purchase.xml"
    end

    def authorize_url(gateway_token)
      "#{base_url}/v1/gateways/#{gateway_token}/authorize.xml"
    end

    def verify_url(gateway_token)
      "#{base_url}/v1/gateways/#{gateway_token}/verify.xml"
    end

    def capture_url(authorization_token)
      "#{base_url}/v1/transactions/#{authorization_token}/capture.xml"
    end

    def void_transaction_url(token)
      "#{base_url}/v1/transactions/#{token}/void.xml"
    end

    def refund_transaction_url(token)
      "#{base_url}/v1/transactions/#{token}/credit.xml"
    end

    def retain_payment_method_url(payment_method_token)
      "#{base_url}/v1/payment_methods/#{payment_method_token}/retain.xml"
    end

    def redact_payment_method_url(payment_method_token)
      "#{base_url}/v1/payment_methods/#{payment_method_token}/redact.xml"
    end

    def recache_payment_method_url(payment_method_token)
      "#{base_url}/v1/payment_methods/#{payment_method_token}/recache.xml"
    end

    def redact_gateway_url(gateway_token)
      "#{base_url}/v1/gateways/#{gateway_token}/redact.xml"
    end

    def store_url(gateway_token)
      "#{base_url}/v1/gateways/#{gateway_token}/store.xml"
    end

    def list_transactions_url(since_token, payment_method_token, options = {})
      options.each do |key, val|
        options[key.to_sym] = val
      end

      params = []
      params << "since_token=#{since_token}" if since_token
      params << "count=#{options[:count]}" if options[:count]
      params << "order=#{options[:order]}" if options[:order]
      params << "state=#{options[:state]}" if options[:state]
      param_string = "?#{params.join('&')}" if params.any?
      return "#{base_url}/v1/transactions.xml#{param_string}" unless payment_method_token

      "#{base_url}/v1/payment_methods/#{payment_method_token}/transactions.xml#{param_string}"
    end

    def list_payment_methods_url(since_token)
      since_param = "?since_token=#{since_token}" if since_token
      "#{base_url}/v1/payment_methods.xml#{since_param}"
    end

    def list_gateways_url(since_token)
      since_param = "?since_token=#{since_token}" if since_token
      "#{base_url}/v1/gateways.xml#{since_param}"
    end

    def list_receivers_url(since_token)
      since_param = "?since_token=#{since_token}" if since_token
      "#{base_url}/v1/receivers.xml#{since_param}"
    end

    def list_supported_receivers_url
      "#{base_url}/v1/receivers_options.xml"
    end

    def gateway_options_url
      "#{base_url}/v1/gateways.xml"
    end

    def add_gateway_url
      "#{base_url}/v1/gateways.xml"
    end

    def receiver_options_url
      "#{base_url}/v1/receivers_options.xml"
    end

    def add_receiver_url
      "#{base_url}/v1/receivers.xml"
    end

    def redact_receiver_url(token)
      "#{base_url}/v1/receivers/#{token}/redact.xml"
    end

    def add_payment_method_url
      "#{base_url}/v1/payment_methods.xml"
    end

    def update_payment_method_url(token)
      "#{base_url}/v1/payment_methods/#{token}.xml"
    end

    def deliver_to_receiver_url(receiver_token)
      "#{base_url}/v1/receivers/#{receiver_token}/deliver.xml"
    end
  end
end
