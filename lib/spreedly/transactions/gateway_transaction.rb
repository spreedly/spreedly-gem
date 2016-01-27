module Spreedly

  class GatewayTransaction < Transaction

    field :order_id, :ip, :description, :gateway_token, :gateway_transaction_id, :email, :transaction_type
    field :merchant_name_descriptor, :merchant_location_descriptor
    field :on_test_gateway, type: :boolean

    attr_reader :response, :gateway_specific_fields, :shipping_address

    def initialize(xml_doc)
      super
      response_xml_doc = xml_doc.at_xpath('.//response')
      shipping_address_xml_doc = xml_doc.at_xpath('.//shipping_address')
      @response = response_xml_doc ? Response.new(response_xml_doc) : nil
      @shipping_address = shipping_address_xml_doc ? ShippingAddress.new(shipping_address_xml_doc) : nil
      @gateway_specific_fields = parse_gateway_specific_fields(xml_doc)
    end

    def parse_gateway_specific_fields(xml_doc)
      result = {}

      xml_doc.at_xpath('.//gateway_specific_fields').xpath('*').each do |node|
        node_name = node.name.to_sym
        if (node.elements.empty?)
          result[node_name] = node.text
        else
          node.elements.each do |childnode|
            result[node_name] ||= {}
            result[node_name][childnode.name.to_sym] = childnode.text
          end
        end
      end

      result
    end
  end

  class Response
    include Fields

    field :success, :pending, :cancelled, :fraud_review, type: :boolean
    field :created_at, :updated_at, type: :date_time
    field :message, :avs_code, :avs_message, :cvv_code, :cvv_message, :error_code, :error_detail

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

  end

  class ShippingAddress
    include Fields

    field :name, :address1, :address2, :city, :state, :zip, :country, :phone_number

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

  end
end
