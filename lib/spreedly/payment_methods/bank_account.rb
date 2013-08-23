module Spreedly

  class BankAccount < PaymentMethod
    field :first_name, :last_name, :full_name, :bank_name
    field :account_type, :account_holder_type, :routing_number_display_digits
    field :account_number_display_digits, :routing_number, :account_number
  end

end
