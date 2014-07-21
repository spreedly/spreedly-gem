require 'test_helper'
require 'unit/response_stubs/deliver_payment_method_stubs'

class DeliverPaymentMethodTest < Test::Unit::TestCase

  include DeliverPaymentMethodStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_deliver_receiver
    @environment.stubs(:raw_ssl_request).returns(successful_deliver_payment_method_response)
    t = @environment.deliver_to_receiver('ReceiverToken', 'PaymentMethodToken',
                                         headers: headers, body: receiver_body, url: url)

    assert_kind_of(Spreedly::DeliverPaymentMethod, t)
    assert_equal 'QguSkyc5F49S2P68RSbA2Eszkhr', t.token
    assert_equal Time.parse("2014-06-20T20:24:57Z"), t.created_at
    assert_equal Time.parse("2014-06-20T20:24:57Z"), t.updated_at
    assert t.succeeded?
    assert_equal 'succeeded', t.state
    assert_equal 'Succeeded!', t.message
    assert_equal '200', t.response.status
    assert_equal 'test', t.receiver.receiver_type
    assert_equal 'TUwHIV9A3CiEizatDZFuic6C9la', t.payment_method.token
  end

  def test_request_body_params
    body = get_request_body(successful_deliver_payment_method_response) do
      @environment.deliver_to_receiver('ReceiverToken', 'PaymentMethodToken',
                                       headers: headers, body: receiver_body, url: url)
    end

    receiver = body.xpath('./delivery')
    assert_xpaths_in receiver,
      [ './payment_method_token', 'PaymentMethodToken' ],
      [ './url', 'http://api.example.com/posts' ],
      [ './headers', "Host: https://api.example.com/posts\nContent-Length: 1024\nContent-Type: application/soap+xml; charset=utf-8\nSOAPAction: https://api.example.com/posts"],
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
