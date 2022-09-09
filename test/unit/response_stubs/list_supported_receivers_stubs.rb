module ListSupportedReceiversStubs

  def successful_list_supported_receivers_response
    StubResponse.succeeded <<-XML
      <receivers>
        <receiver>
          <name>Example Production</name>
          <company_name>Example Inc</company_name>
          <receiver_type>example_inc</receiver_type>
          <hostnames>https://api.example.com</hostnames>
        </receiver>
        <receiver>
          <name>Example Sandbox</name>
          <company_name>Example Inc</company_name>
          <receiver_type>example_inc_sandbox</receiver_type>
          <hostnames>https://api-sandbox.example.com</hostnames>
        </receiver>
      </receivers>
    XML
  end
end
