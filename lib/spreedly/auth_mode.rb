module Spreedly
  class AuthMode
    include Fields

    field :auth_mode_type, :name
    attr_reader :auth_mode_type, :credentials

    def initialize(xml_doc)
      initialize_fields(xml_doc)

      @credentials = xml_doc.xpath('.//credentials/credential').map do |each|
        Spreedly::Credential.new(each)
      end
    end
  end
end