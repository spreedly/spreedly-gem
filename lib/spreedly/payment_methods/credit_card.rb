module Spreedly

  class CreditCard < PaymentMethod
    field :first_name, :last_name, :full_name, :month, :year
    field :number, :last_four_digits, :card_type, :verification_value
    field :address1, :address2, :city, :state, :zip, :country, :phone_number
  end

end
