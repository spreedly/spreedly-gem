module ReceiverOptionsStubs

  def successful_receiver_options_response
    StubResponse.succeeded <<-XML
      <receivers>
        <receiver>
          <name>Api</name>
          <receiver_type>test</receiver_type>
          <hostnames>http://api.example.com/post</hostnames>
          <company_name>The Example API</company>
        </receiver>
        <receiver>
          <name>Funny</name>
          <receiver_type>test</receiver_type>
          <hostnames>http://funny.pretend.example.com</hostnames>
          <company_name>Funny Pretend</company>
        </receiver>
      </receivers>
    XML
  end

end
