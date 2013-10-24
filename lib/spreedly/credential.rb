module Spreedly
  class Credential
    include Fields

    field :name, :label, :safe

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end
  end
end