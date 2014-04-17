module Spreedly

  class Purchase < AuthPurchase
    field :gateway_transaction_id, type: :integer
  end

end
