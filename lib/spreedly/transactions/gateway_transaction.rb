module Spreedly

  class GatewayTransaction < Transaction

    field :order_id, :ip, :description, :gateway_token
    field :merchant_name_descriptor, :merchant_location_descriptor

    attr_reader :response

    def initialize(xml_doc)
      super
      @response = Response.new(xml_doc.at_xpath('.//response'))
    end

  end

  class Response
    include Fields

    field :success, :pending, :cancelled, type: :boolean
    field :created_at, :updated_at, type: :date_time
    field :message, :avs_code, :avs_message, :cvv_code, :cvv_message, :error_code, :error_detail

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

  end

end
