module Spreedly

  class ReceiverClass
    include Fields

    field :receiver_type, :hostnames, :name, :company_name

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

    def self.new_list_from(xml_doc)
      receivers = xml_doc.xpath('.//receivers/receiver')
      receivers.map do |each|
        self.new(each)
      end
    end

  end

end
