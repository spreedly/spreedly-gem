module GooglePaymentTokenStubs
  def google_pay_token
    token = <<~TEXT
      <google_pay>
        <payment_data>
          <![CDATA[{"signature":"MEUCIA6SGVRwhOyeYRkeDUUNwB/kGtyfQAlOsg7NZydT17u/AiEA48BhWGQEF1EbEU0J+m8eSK3rTfhok9QqpiFVbME+Ky0\u003d","protocolVersion":"ECv1","signedMessage":"{\"encryptedMessage\":\"3v4IcT/eovIDP2WF8iRUy4qWQnE9Cx0vQxIZ5f9i3Emv3Tzs1AzvB7cxXhxrjp9FVIzdOwsZAPAsm03gvoYq8Xdr70XvrVRd2MFwQhMC7IV/uEsthw4JsR8oCkbI5v/zqhu2B+JodFgavNliHcpKBgijy2D6bpx7jXEkM39M/L4oBObFxFrhVSLA1GjOV6A5gLAXNXt0ffkCYekihqAyJrWlk3sCBDCF5SUiAKEIOIZtzZLgusxjVp6ufZHOHm/53uhAi6JWSJ1E6G5aaYGtULYdwgURHtxN5OIzQPYlEGctaQd5tgfCsBFfGkYyN1GRNgclbaLzAfk/Jn7/6IVKuV0ol3xubTcnjGTZXwtTjiEyYDoz1yVqB9ViMmJa55L6nBtbbAkcNEgAi7dPnrbvBGEP7QWsNT9D71g8SWrlRTCYUAOyuamaQhofG4ul1IVjmltdAy2BHBWpqgJnR9kczydQyE7uDiqhSC1/0eG8GCGIqoi8XfOioGXfMyLZ1p2ZcNK9ECjzUrH/edrwgtShxgWuWMwQTM4DQlVTAA/R4DVs192YWZcc7jm5wLqZ0+XEaPuighJM1Ps1Egeccg\\u003d\\u003d\",\"ephemeralPublicKey\":\"BA2SvF9BdCX7Tl1wwRkyLzTfqhctobhZgSugC9Cz77XNUCBOBMfFyJQt506PUs89D6IJZZfOkZopy0shRF9Uph4\\u003d\",\"tag\":\"Uhin1BE7KAuuiam7eEQFimRUDd9Xn6tZc2fClTpfrXQ\\u003d\"}"}
]]>
        </payment_data>
        <test_card_number>4111111111111111</test_card_number> <!-- Remove in production -->
      </google_pay>
    TEXT
  end
end
