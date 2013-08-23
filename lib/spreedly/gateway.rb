
module Spreedly

  class Gateway < Model

    field :gateway_type, :state, :name
    attr_reader :credentials

    def initialize(xml_doc)
      super
      init_credentials(xml_doc)
    end


    private
    def init_credentials(xml_doc)
      @credentials = {}

      xml_doc.xpath('.//credentials/credential').each do |each|
        @credentials[each.at_xpath('.//name').text] = each.at_xpath('.//value').text
      end
    end

  end

end
