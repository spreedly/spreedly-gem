module GooglePaymentTokenStubs
  def google_pay_token
    token = <<~TEXT
      {
        \"id\": \"tok_1MlBaz2eZvKYlo2CPc10bZk7\",
        \"object\": \"token\",
        \"card\": {
          \"id\“: \"card_1MlBaz2eZvKYlo2CSQePRnSi\",
          \"object\“: \"card\",
          \"address_city\": \"Mountain View\",
          \"address_country\": \“US\",
          \"address_line1\": \"1600 Amphitheatre Parkway\",
          \"address_line1_check\": \"unchecked\",
          \"address_line2\": null,
          \"address_state\": \"CA\",
          \"address_zip\": \"94043\",
          \"address_zip_check\": \"unchecked\",
          \"brand\": \"Visa\",
          \"country\": \"US\",
          \"cvc_check\": null,
          \"dynamic_last4\": \"1111\",
          \"exp_month\": 12,
          \"exp_year\": 2025,
          \"funding\": \"credit\",
          \"last4\": \"1111\",
          \"metadata\": {},
          \"name\": null,
          \"tokenization_method\": \"android_pay\"
        },
        \"client_ip\": \"209.85.198.209\",
        \"created\": 1678714765,
        \"livemode\": false,
        \"type\": \"card\",
        \"used\": false
      }
    TEXT
  end
end
