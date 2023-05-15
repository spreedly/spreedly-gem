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
      transcript_url = find_transcript_url(transaction_token)
      ssl_raw_get(transcript_url, headers)
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

    def complete_transaction(transaction_token)
      api_post(complete_transaction_url(transaction_token), '')
    end

    def verify_on_gateway(gateway_token, payment_method_token, options = {})
      body = verify_body(payment_method_token, options)
      api_post(verify_url(gateway_token), body)
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

    def recache_payment_method(payment_method_token, options = {})
      body = recache_payment_method_body(options)
      xml_doc = ssl_put(recache_payment_method_url(payment_method_token), body, headers)
      RecacheSensitiveData.new_from(xml_doc)
    end

    def redact_gateway(gateway_token, options = {})
      xml_doc = ssl_put(redact_gateway_url(gateway_token), '', headers)
      Transaction.new_from(xml_doc)
    end

    def redact_receiver(receiver_token, options = {})
      xml_doc = ssl_put(redact_receiver_url(receiver_token), '', headers)
      Transaction.new_from(xml_doc)
    end

    def list_transactions(since_token = nil, payment_method_token = nil, options = {})
      xml_doc = ssl_get(list_transactions_url(since_token, payment_method_token, options), headers)
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

    def store_on_gateway(gateway_token, payment_method_token, options = {})
      body = store_body(payment_method_token, options)
      api_post(store_url(gateway_token), body)
    end

    def gateway_options
      xml_doc = ssl_get(gateway_options_url, headers)
      GatewayClass.new_list_from(xml_doc)
    end

    def self.gateway_options
      self.new("", "").gateway_options
    end

    def receiver_options
      xml_doc = ssl_get(receiver_options_url, headers)
      ReceiverClass.new_list_from(xml_doc)
    end

    def self.receiver_options
      self.new("", "").receiver_options
    end

    def add_gateway(gateway_type, credentials = {})
      body = add_gateway_body(gateway_type, credentials)
      xml_doc = ssl_post(add_gateway_url, body, headers)
      Gateway.new(xml_doc)
    end

    def add_receiver(receiver_type, host_names = nil, credentials = [])
      body = add_receiver_body(receiver_type, host_names, credentials)
      xml_doc = ssl_post(add_receiver_url, body, headers)
      Receiver.new(xml_doc)
    end

    def add_credit_card(options)
      api_post(add_payment_method_url, add_credit_card_body(options), false)
    end

    def update_credit_card(credit_card_token, options)
      body = update_credit_card_body(options)
      xml_doc = ssl_put(update_payment_method_url(credit_card_token), body, headers)
      PaymentMethod.new_from(xml_doc)
    end

    def deliver_to_receiver(receiver_token, payment_method_token, receiver_options)
      body = deliver_to_receiver_body(payment_method_token, receiver_options)
      api_post(deliver_to_receiver_url(receiver_token), body)
    end

    private
    def headers
      {
        'Authorization' => ('Basic ' + Base64.strict_encode64("#{@key}:#{@access_secret}").chomp),
        'Content-Type' => 'text/xml',
        'User-Agent' => "spreedly-gem/#{Spreedly::VERSION}"
      }
    end

    def auth_purchase_body(amount, payment_method_token, options)
      build_xml_request('transaction') do |doc|
        doc.amount amount
        doc.currency_code(options[:currency_code] || currency_code)
        add_payment_token(doc, payment_method_token, options)
        add_to_doc(doc, options, :retain_on_success)
        add_to_doc(doc, options, :stored_credential_initiator)
        add_to_doc(doc, options, :stored_credential_reason_type)
        add_extra_options_for_basic_ops(doc, options)
      end
    end

    def add_payment_token(doc, payment_method_token, options = {})
      if options[:payment_method] == :google_pay
        doc << <<~XML
          <google_pay>
            <payment_data><![CDATA[#{payment_method_token}]]></payment_data>
            #{'<test_card_number>4111111111111111</test_card_number>' if options[:test_mode]}
          </google_pay>
        XML
      elsif options[:payment_method] == :apple_pay
        doc << <<~XML
          <apple_pay>
            <payment_data><![CDATA[#{payment_method_token}]]></payment_data>
            #{'<test_card_number>4111111111111111</test_card_number>' if options[:test_mode]}
          </apple_pay>
        XML
      else # if credit card
        doc.payment_method_token(payment_method_token)
      end
    end

    def verify_body(payment_method_token, options)
      build_xml_request('transaction') do |doc|
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

    def recache_payment_method_body(options)
      build_xml_request('payment_method') do |doc|
        doc.credit_card do
          add_to_doc(doc, options, :verification_value)
        end
      end
    end

    def add_gateway_body(gateway_type, credentials)
      build_xml_request('gateway') do |doc|
        doc.gateway_type gateway_type
        add_to_doc(doc, credentials, *credentials.keys)
      end
    end

    def add_receiver_body(receiver_type, host_names, credentials)
      build_xml_request('receiver') do |doc|
        doc.receiver_type receiver_type
        doc.hostnames(host_names) if host_names
        add_credentials_to_doc(doc, credentials) if credentials && !credentials.empty?
      end
    end

    def store_body(payment_method_token, options)
      build_xml_request('transaction') do |doc|
        doc.payment_method_token(payment_method_token)
        add_gateway_specific_fields(doc, options)
      end
    end

    def add_credentials_to_doc(doc, credentials)
      doc.credentials do
        credentials.each do |credential|
          doc.credential do
            add_to_doc(doc, credential, :name, :value, :safe)
          end
        end
      end
    end

    def add_credit_card_body(options)
      build_xml_request('payment_method') do |doc|
        add_to_doc(doc, options, :data, :retained, :email)
        doc.credit_card do
          add_to_doc(doc, options, :number, :verification_value, :month, :full_name, :first_name, :last_name,
                     :year, :address1, :address2, :city, :state, :zip, :country, :phone_number,
                     :company, :eligible_for_card_updater)
        end
      end
    end

    def update_credit_card_body(options)
      build_xml_request('payment_method') do |doc|
        add_to_doc(doc, options, :email, :month, :full_name, :first_name, :last_name, :year,
                   :address1, :address2, :city, :state, :zip, :country, :phone_number,
                   :eligible_for_card_updater)
      end
    end

    def deliver_to_receiver_body(payment_method_token, receiver_options)
      build_xml_request('delivery') do |doc|
        doc.payment_method_token payment_method_token
        doc.url receiver_options[:url]
        doc.headers do
          doc.cdata receiver_options[:headers].map { |k, v| "#{k}: #{v}" }.join("\r\n")
        end
        doc.body do
          doc.cdata receiver_options[:body]
        end
      end
    end

    def add_to_doc(doc, options, *attributes)
      attributes.each do |attr|
        doc.send(attr, options[attr.to_sym]) if options[attr.to_sym] != nil
      end
    end

    def add_extra_options_for_basic_ops(doc, options)
      add_gateway_specific_fields(doc, options)
      add_shipping_address_override(doc, options)
      add_to_doc(doc, options, :order_id, :description, :ip, :email, :merchant_name_descriptor,
                               :merchant_location_descriptor, :redirect_url, :callback_url,
                               :continue_caching, :attempt_3dsecure, :browser_info, :three_ds_version, :channel)
    end

    def add_gateway_specific_fields(doc, options)
      return unless options[:gateway_specific_fields].kind_of?(Hash)
      doc << "<gateway_specific_fields>#{xml_for_hash(options[:gateway_specific_fields])}</gateway_specific_fields>"
    end

    def add_shipping_address_override(doc, options)
      return unless options[:shipping_address].kind_of?(Hash)
      doc.send(:shipping_address) do
        options[:shipping_address].each do |k, v|
          doc.send(k, v)
        end
      end
    end

    def xml_for_hash(hash)
      hash.map do |key, value|
        text = value.kind_of?(Hash) ? xml_for_hash(value) : value
        "<#{key}>#{text}</#{key}>"
      end.join
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
