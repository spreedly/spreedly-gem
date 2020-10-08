module AddReceiverStubs

  def successful_add_receiver_response
    StubResponse.succeeded <<-XML
      <receiver>
        <receiver_type>test</receiver_type>
        <token>6SzKN5kR5QSa7JvGFwpjka9zkBA</token>
        <hostnames>http://api.example.com/post</hostnames>
        <state>retained</state>
        <created_at>2014-05-21T21:39:08Z</created_at>
        <updated_at>2014-05-21T21:39:08Z</updated_at>
        <credentials>
          <credential>
            <name>app-id</name>
            <value>1234</value>
            <safe>true</safe>
          </credential>
          <credential>
            <name>app-secret</name>
          </credential>
        </credentials>
      </receiver>
    XML
  end

end
