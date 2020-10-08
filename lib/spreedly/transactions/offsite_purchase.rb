module Spreedly

  class OffsitePurchase < AuthPurchase
    field :checkout_url, :redirect_url, :callback_url
  end

end
