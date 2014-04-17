module Spreedly

  class Authorization < AuthPurchase
    field :gateway_transaction_id, type: :integer
  end

end
