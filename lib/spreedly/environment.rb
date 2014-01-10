require 'base64'
require 'nokogiri'

module Spreedly
  class Environment

    include SslRequester
    include Urls

    attr_reader :key, :currency_code, :base_url

    def initialize(environment_key, access_secret, options={})
      @key, @access_secret = environment_key, access_secret
      @base_url = options[:base_url] || "https://core.spreedly.com"
      @currency_code = options[:currency_code] || 'USD'
    end

    def transparent_redirect_form_action
      "#{base_url}/v1/payment_methods"
    end

    def find_payment_method(token)
      xml_doc = ssl_get(find_payment_method_url(token), headers)
      PaymentMethod.new_from(xml_doc)
    end

    def find_transaction(token)
      xml_doc = ssl_get(find_transaction_url(token), headers)
      Transaction.new_from(xml_doc)
    end

    def find_transcript(transaction_token)
      ssl_raw_get(find_transcript_url(transaction_token), headers)
    end

    def find_gateway(token)
      xml_doc = ssl_get(find_gateway_url(token), headers)
      Gateway.new(xml_doc)
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

    def retain_payment_method(payment_method_token)
      xml_doc = ssl_put(retain_payment_method_url(payment_method_token), '', headers)
      Transaction.new_from(xml_doc)
    end

    def redact_payment_method(payment_method_token, options = {})
      body = redact_payment_method_body(options)
      xml_doc = ssl_put(redact_payment_method_url(payment_method_token), body, headers)
      Transaction.new_from(xml_doc)
    end

    def redact_gateway(gateway_token, options = {})
      xml_doc = ssl_put(redact_gateway_url(gateway_token), '', headers)
      Transaction.new_from(xml_doc)
    end

    def list_transactions(since_token = nil, payment_method_token = nil)
      xml_doc = ssl_get(list_transactions_url(since_token, payment_method_token), headers)
      Transaction.new_list_from(xml_doc)
    end

    def list_payment_methods(since_token = nil)
      xml_doc = ssl_get(list_payment_methods_url(since_token), headers)
      PaymentMethod.new_list_from(xml_doc)
    end

    def list_gateways(since_token = nil)
      xml_doc = ssl_get(list_gateways_url(since_token), headers)
      Gateway.new_list_from(xml_doc)
    end

    def gateway_options
      xml_doc = ssl_options(gateway_options_url)
      GatewayClass.new_list_from(xml_doc)
    end

    def self.gateway_options
      self.new("", "").gateway_options
    end

    def add_gateway(gateway_type, credentials = {})
      body = add_gateway_body(gateway_type, credentials)
      xml_doc = ssl_post(add_gateway_url, body, headers)
      Gateway.new(xml_doc)
    end

    def add_credit_card(options)
      api_post(add_payment_method_url, add_credit_card_body(options), false)
    end

    def update_credit_card(credit_card_token, options)
      body = update_credit_card_body(options)
      xml_doc = ssl_put(update_payment_method_url(credit_card_token), body, headers)
      PaymentMethod.new_from(xml_doc)
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
        add_to_doc(doc, options, :retain_on_success)
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

    def redact_payment_method_body(options)
      return '' if options.empty?
      build_xml_request('transaction') do |doc|
        add_to_doc(doc, options, :remove_from_gateway)
      end
    end

    def add_gateway_body(gateway_type, credentials)
      build_xml_request('gateway') do |doc|
        doc.gateway_type gateway_type
        add_to_doc(doc, credentials, *credentials.keys)
      end
    end

    def add_credit_card_body(options)
      build_xml_request('payment_method') do |doc|
        add_to_doc(doc, options, :data, :retained, :email)
        doc.credit_card do
          add_to_doc(doc, options, :number, :verification_value, :month, :first_name, :last_name,
                     :year, :address1, :address2, :city, :state, :zip, :country, :phone_number)
        end
      end
    end

    def update_credit_card_body(options)
      build_xml_request('payment_method') do |doc|
        add_to_doc(doc, options, :email, :month, :first_name, :last_name, :year,
                   :address1, :address2, :city, :state, :zip, :country, :phone_number)
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

    def api_post(url, body, talking_to_gateway = true)
      xml_doc = ssl_post(url, body, headers, talking_to_gateway)
      Transaction.new_from(xml_doc)
    end

  end
end
