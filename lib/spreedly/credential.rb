module Spreedly
  class Credential
    include Fields

    field :name, :label
    field :safe, type: :boolean

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end
  end
end
