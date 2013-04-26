module Spreedly

  class CreditCard < PaymentMethod
    field :first_name, :last_name, :number, :last_four_digits, :card_type, :verification_value
    field :month, :year, :address1, :address2, :city, :state, :country, :phone_number

  end

end
