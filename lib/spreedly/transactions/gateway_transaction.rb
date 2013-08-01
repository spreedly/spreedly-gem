module Spreedly

  class GatewayTransaction < Transaction

    field :order_id, :ip, :description, :gateway_token
    field :merchant_name_descriptor, :merchant_location_descriptor

  end

end
