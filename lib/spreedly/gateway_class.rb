module Spreedly

  class GatewayClass
    include Fields

    field :gateway_type, :name, :homepage, :company_name
    field :supports_purchase, :supports_authorize, :supports_capture, :supports_credit,
          :supports_void, :supports_verify, :supports_reference_purchase,
          :supports_purchase_via_preauthorization, :supports_offsite_purchase,
          :supports_offsite_authorize, :supports_3dsecure_purchase, :supports_3dsecure_authorize,
          :supports_store, :supports_remove, :supports_general_credit,
          :supports_fraud_review, type: :boolean

    attr_reader :supported_countries, :payment_methods, :auth_modes, :regions

    def initialize(xml_doc)
      initialize_fields(xml_doc)
      init_supported_countries(xml_doc)
      init_regions(xml_doc)
      init_payment_methods(xml_doc)
      init_auth_modes(xml_doc)
    end

    def self.new_list_from(xml_doc)
      gateways = xml_doc.xpath('.//gateways/gateway')
      gateways.map do |each|
        self.new(each)
      end
    end

    private

    def init_supported_countries(xml_doc)
      list = xml_doc.at_xpath(".//supported_countries").inner_html.strip
      @supported_countries = list.split(/\s*,\s*/)
    end

    def init_regions(xml_doc)
      list = xml_doc.at_xpath(".//regions").inner_html.strip
      @regions = list.split(/\s*,\s*/)
    end

    def init_payment_methods(xml_doc)
      @payment_methods = xml_doc.xpath('.//payment_methods/payment_method').map do |each|
        each.text
      end
    end

    def init_auth_modes(xml_doc)
      @auth_modes = xml_doc.xpath(".//auth_modes/auth_mode").map do |each|
        Spreedly::AuthMode.new(each)
      end
    end

  end

end
