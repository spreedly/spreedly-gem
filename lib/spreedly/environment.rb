require 'base64'
require 'nokogiri'

module Spreedly
  class Environment

    include SslRequester
    include Urls

    attr_reader :key, :currency_code

    def initialize(environment_key, access_secret, options={})
      @key, @access_secret = environment_key, access_secret
      @currency_code = options[:currency_code] || 'USD'
    end

    def transparent_redirect_form_action
      "#{base_url}/v1/payment_methods"
    end

    def find_payment_method(token)
      xml_doc = ssl_get(find_payment_method_url(token), headers)
      PaymentMethod.new_from(xml_doc)
    end

    def purchase_on_gateway(gateway_token, payment_method_token, amount, options = {})
      body = auth_purchase_body(amount, payment_method_token, options)
      api_post(purchase_url(gateway_token), body)
    end

    def authorize_on_gateway(gateway_token, payment_method_token, amount, options = {})
      body = auth_purchase_body(amount, payment_method_token, options)
      api_post(authorize_url(gateway_token), body)
    end

    def capture_transaction(authorization_token, options = {})
      api_post(capture_url(authorization_token), capture_body(options))
    end

    def void_transaction(token, options = {})
      api_post(void_transaction_url(token), void_body(options))
    end

    def refund_transaction(token, options = {})
      api_post(refund_transaction_url(token), refund_body(options))
    end

    def add_credit_card(options)
      api_post(add_payment_method_url, add_credit_card_body(options))
    end

    def add_gateway(gateway_type, options = {})
      body = add_gateway_body(gateway_type, options)
      xml_doc = ssl_post(add_gateway_url, body, headers)
      Gateway.new(xml_doc)
    end


    private
    def headers
      {
        'Authorization' => ('Basic ' + Base64.strict_encode64("#{@key}:#{@access_secret}").chomp),
        'Content-Type' => 'text/xml'
      }
    end

    def auth_purchase_body(amount, payment_method_token, options)
      build_xml_request('transaction') do |doc|
        doc.amount amount
        doc.currency_code(options[:currency_code] || currency_code)
        doc.payment_method_token(payment_method_token)
        add_extra_options_for_basic_ops(doc, options)
      end
    end

    def capture_body(options)
      return '' if options.empty?

      build_xml_request('transaction') do |doc|
        add_to_doc(doc, options, :amount, :currency_code)
        add_extra_options_for_basic_ops(doc, options)
      end
    end

    def void_body(options)
      return '' if options.empty?

      build_xml_request('transaction') do |doc|
        add_extra_options_for_basic_ops(doc, options)
      end
    end

    def refund_body(options)
      return '' if options.empty?

      build_xml_request('transaction') do |doc|
        add_to_doc(doc, options, :amount, :currency_code)
        add_extra_options_for_basic_ops(doc, options)
      end
    end

    def add_gateway_body(gateway_type, options)
      build_xml_request('gateway') do |doc|
        doc.gateway_type gateway_type
      end
    end

    def add_credit_card_body(options)
      build_xml_request('payment_method') do |doc|
        add_to_doc(doc, options, :data, :retained, :email)
        doc.credit_card do
          add_to_doc(doc, options, :number, :month, :first_name, :last_name, :year,
                     :address1, :address2, :city, :state, :zip, :country, :phone_number)
        end
      end
    end

    def add_to_doc(doc, options, *attributes)
      attributes.each do |attr|
        doc.send(attr, options[attr.to_sym]) if options[attr.to_sym]
      end
    end

    def add_extra_options_for_basic_ops(doc, options)
      add_to_doc(doc, options, :order_id, :description, :ip, :merchant_name_descriptor,
                               :merchant_location_descriptor)
    end

    def build_xml_request(root)
      builder = Nokogiri::XML::Builder.new
      builder.__send__(root) do |doc|
        yield(doc)
      end
      builder.to_xml
    end

    def api_post(url, body)
      xml_doc = ssl_post(url, body, headers)
      Transaction.new_from(xml_doc)
    end

  end
end
