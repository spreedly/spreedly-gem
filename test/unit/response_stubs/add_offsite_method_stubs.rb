module AddOffsiteMethodStubs

  def successful_add_offsite_method_response
    StubResponse.succeeded <<-XML
      <transaction>
        <token>offsite-transaction-token</token>
        <created_at type="datetime">2013-08-02T18:04:45Z</created_at>
        <updated_at type="datetime">2013-08-02T18:04:45Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <transaction_type>AddPaymentMethod</transaction_type>
        <retained type="boolean">false</retained>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <state>succeeded</state>
        <payment_method>
          <token>offsite-payment-method-token</token>
          <created_at type="datetime">2013-08-02T18:04:45Z</created_at>
          <updated_at type="datetime">2013-08-02T18:04:45Z</updated_at>
          <email>me@joey.io</email>
          <data>Just some payment method data here, no need to worry.</data>
          <storage_state>cached</storage_state>
          <full_name>Joey Beninghove</full_name>
          <eligible_for_card_updater type="boolean">true</eligible_for_card_updater>
          <payment_method_type>sprel</payment_method_type>
          <errors>
          </errors>
        </payment_method>
      </transaction>
      XML
  end
end
