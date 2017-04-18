module AddBankAccountStubs

  def successful_add_bank_account_response
    StubResponse.succeeded <<-XML
      <transaction>
        <token>CTRCfhdWDaJ5DBfUw2mbxUISux4</token>
        <created_at type="dateTime">2015-12-02T20:47:13Z</created_at>
        <updated_at type="dateTime">2015-12-02T20:47:13Z</updated_at>
        <succeeded type="boolean">true</succeeded>
        <transaction_type>AddPaymentMethod</transaction_type>
        <retained type="boolean">false</retained>
        <state>succeeded</state>
        <message key="messages.transaction_succeeded">Succeeded!</message>
        <payment_method>
          <token>PsZvGrh0mIrmxzHQUNAscxyA7B1</token>
          <created_at type="dateTime">2015-12-02T20:47:13Z</created_at>
          <updated_at type="dateTime">2015-12-02T20:47:13Z</updated_at>
          <email>joey@example.com</email>
          <data>
            <my_payment_method_identifier>448</my_payment_method_identifier>
            <extra_stuff>
              <some_other_things>Can be anything really</some_other_things>
            </extra_stuff>
          </data>
          <storage_state>cached</storage_state>
          <test type="boolean">true</test>
          <full_name>Joey Jones</full_name>
          <bank_name nil="true"></bank_name>
          <account_type>checking</account_type>
          <account_holder_type>personal</account_holder_type>
          <routing_number_display_digits>021</routing_number_display_digits>
          <account_number_display_digits>3210</account_number_display_digits>
          <first_name>Joey</first_name>
          <last_name>Jones</last_name>
          <payment_method_type>bank_account</payment_method_type>
          <errors>
          </errors>
          <routing_number>021*</routing_number>
          <account_number>*3210</account_number>
        </payment_method>
      </transaction>
      XML
  end
end
