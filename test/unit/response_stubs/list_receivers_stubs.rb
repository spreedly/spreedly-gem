module ListReceiversStubs

  def successful_list_receivers_response
    StubResponse.succeeded <<-XML
      <receivers>
        <receiver>
          <company_name>Example Inc</company_name>
          <receiver_type>example_inc</receiver_type>
          <token>OJUFe5ZR6pFfL4i4ZGVmvGWkZUY</token>
          <hostnames>https://api.example.com</hostnames>
          <state>retained</state>
          <created_at type="dateTime">2014-07-18T19:13:52Z</created_at>
          <updated_at type="dateTime">2020-07-29T20:50:27Z</updated_at>
          <credentials type="array">
            <credential>
              <name>user_name</name>
              <value>test_user</value>
              <safe>true</safe>
            </credential>
            <credential>
              <name>password</name>
              <safe>false</safe>
            </credential>
          </credentials>
        </receiver>
        <receiver>
          <company_name>Example Inc</company_name>
          <receiver_type>example_inc</receiver_type>
          <token>52wqOssuKZSXEYde30AGTG6xl8v</token>
          <hostnames>https://api.example.com</hostnames>
          <state>retained</state>
          <created_at type="dateTime">2014-07-18T19:13:52Z</created_at>
          <updated_at type="dateTime">2020-07-29T20:46:46Z</updated_at>
          <credentials type="array">
            <credential>
              <name>user_name</name>
              <value>test_user2</value>
              <safe>true</safe>
            </credential>
            <credential>
              <name>password</name>
              <safe>false</safe>
            </credential>
          </credentials>
        </receiver>
      </receivers>
    XML
  end
end
