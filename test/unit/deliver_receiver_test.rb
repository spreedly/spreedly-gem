require 'test_helper'
require 'unit/response_stubs/deliver_receiver_stubs'

class DeliverReceiverTest < Test::Unit::TestCase

  include DeliverReceiverStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_deliver_receiver
    @environment.stubs(:raw_ssl_request).returns(successful_deliver_receiver_response)

    receiver = @environment.deliver_receiver(receiver_token: '__receiver_token__',
                                            payment_method_token: '__payment_method_token__',
                                            receiver_headers: headers,
                                            receiver_body: receiver_body,
                                            url: url)
  end

  def test_request_body_params
    body = get_request_body(successful_deliver_receiver_response) do
      @environment.deliver_receiver(receiver_token: '__receiver_token__',
                                    payment_method_token: '__payment_method_token__',
                                    receiver_headers: headers,
                                    receiver_body: receiver_body,
                                    url: url)
    end

    receiver = body.xpath('./delivery')
    assert_xpaths_in receiver,
      [ './payment_method_token', '__payment_method_token__' ],
      [ './url', 'http://api.example.com/posts' ],
      [ './headers', "Content-Type: application/soap+xml; charset=utf-8
SOAPAction: https://api.example.com/posts" ],
      ['./body', receiver_body]
  end

  private


  def headers
    {
      'Host' => 'https://api.example.com/posts',
      'Content-Length' => 1024,
      'Content-Type' => 'application/soap+xml; charset=utf-8',
      'SOAPAction' => "https://api.example.com/posts"
    }
  end

  def receiver_body
    <<-XML
      <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
        <soap12:Body>
          <addCOF xmlns="http://api.example.com/">
            <NameOnCard>string</NameOnCard>
            <CardNumber>string</CardNumber>
            <ExpMonth>int</ExpMonth>
            <ExpYear>int</ExpYear>
            <CSC>string</CSC>
          </addCOF>
        </soap12:Body>
      </soap12:Envelope>
    XML
  end

  def url
    'http://api.example.com/posts'
  end

end
