require 'base64'
require 'nokogiri'

module Spreedly
  class Environment

    include SslRequester

    attr_reader :key, :currency_code

    def initialize(environment_key, access_secret, options={})
      @key, @access_secret = environment_key, access_secret
      @currency_code = options[:currency_code] || 'USD'
    end

    def transparent_redirect_form_action
      "#{base_url}/v1/payment_methods"
    end

    def find_payment_method(token)
      raw_response = ssl_get("#{base_url}/v1/payment_methods/#{token}.xml", headers)
      payment_method_from(parse_xml(raw_response))
    end

    def purchase_on_gateway(gateway_token, payment_method_token, amount, options = {})

    end

    private
    def base_url
      "https://core.spreedly.com"
    end

    def headers
      {
        'Authorization' => ('Basic ' + Base64.strict_encode64("#{@key}:#{@access_secret}").chomp),
        'Content-Type' => 'text/xml'
      }
    end

    def payment_method_from(parsed_response)
      case parsed_response[:payment_method_type]
      when 'credit_card'
        return CreditCard.new(parsed_response)
      when 'sprel'
        return Sprel.new(parsed_response)
      end
    end

  end
end
