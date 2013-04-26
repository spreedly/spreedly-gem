require 'base64'
require 'nokogiri'

module Spreedly
  class Environment

    include SslRequester

    def initialize(environment_key, access_secret)
      @environment_key, @access_secret = environment_key, access_secret
    end

    def transparent_redirect_form_action
      "#{base_url}/v1/payment_methods"
    end

    def find_payment_method(token)
      raw_response = ssl_get("#{base_url}/v1/payment_methods/#{token}.xml", headers)
      payment_method_from(parse(raw_response))
    end

    private
    def base_url
      "https://core.spreedly.com"
    end

    def headers
      {
        'Authorization' => ('Basic ' + Base64.strict_encode64("#{@environment_key}:#{@access_secret}").chomp),
        'Content-Type' => 'text/xml'
      }
    end

    def parse(xml)
      response = {}

      doc = Nokogiri::XML(xml)
      doc.root.xpath('*').each do |node|
        if (node.elements.empty?)
          response[node.name.downcase.to_sym] = node.text
        else
          response[node.name.downcase.to_sym] = node.elements.to_xml
        end
      end

      response
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
