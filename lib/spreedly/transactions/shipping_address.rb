module Spreedly
  class ShippingAddress
    include Fields

    field :name, :address1, :address2, :city, :state, :zip, :country, :phone_number

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end
  end
end
