
module Spreedly

  class Receiver < Model

    field :receiver_type, :hostnames, :state, :company_name
    attr_reader :credentials

    def initialize(xml_doc)
      super
      init_credentials(xml_doc)
    end

    def self.new_list_from(xml_doc)
      receivers = xml_doc.xpath('.//receivers/receiver')
      receivers.map do |each|
        self.new(each)
      end
    end

    private
    def init_credentials(xml_doc)
      @credentials = {}

      xml_doc.xpath('.//credentials/credential').each do |each|
        @credentials[each.at_xpath('.//name').text] = cred_value(each)
      end
    end

    def cred_value(cred)
      value = cred.at_xpath('.//value')
      value ? value.text : nil
    end

  end

end
