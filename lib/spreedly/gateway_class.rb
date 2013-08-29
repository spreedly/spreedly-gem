module Spreedly

  class GatewayClass

    include Fields
    field :gateway_type, :name, :supported_countries, :homepage
    attr_reader :supported_countries, :payment_methods

    def initialize(xml_doc)
      initialize_fields(xml_doc)
      init_supported_countries(xml_doc)
      init_payment_methods(xml_doc)
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

    def init_payment_methods(xml_doc)
      @payment_methods = xml_doc.xpath('.//payment_methods/payment_method').map do |each|
        each.text
      end
    end

  end

end
