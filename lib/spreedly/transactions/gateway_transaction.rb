module Spreedly

  class GatewayTransaction < Transaction

    field :order_id, :ip, :description, :merchant_name_descriptor, :merchant_location_descriptor
    field :gateway_token

  end

end
