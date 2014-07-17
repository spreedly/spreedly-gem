require 'test_helper'
require 'unit/response_stubs/add_receiver_stubs'

class AddReceiverTest < Test::Unit::TestCase

  include AddReceiverStubs

  def setup
    @environment = Spreedly::Environment.new("key", "secret")
  end

  def test_add_receiver
    @environment.stubs(:raw_ssl_request).returns(successful_add_receiver_response)

    receiver = @environment.add_receiver(:test, 'http://api.example.com/post')
    assert_equal("6SzKN5kR5QSa7JvGFwpjka9zkBA", receiver.token)
    assert_equal("test", receiver.receiver_type)
    assert_equal('http://api.example.com/post', receiver.hostnames)
    assert_equal({"app-id"=>"1234", "app-secret"=>nil}, receiver.credentials)
  end

  def test_request_body_params
    body = get_request_body(successful_add_receiver_response) do
      @environment.add_receiver(:test, 'http://api.example.com/post', receiver_test_credentials)
    end

    receiver = body.xpath('./receiver')
    assert_xpaths_in receiver,
      [ './receiver_type', 'test' ],
      [ './hostnames', 'http://api.example.com/post' ]

    first_cred = receiver.xpath('./credentials/credential')[0]
    assert_xpaths_in first_cred,
      [ './name', 'partner_id' ],
      [ './value', 'the_id' ],
      [ './safe', 'true' ]

    second_cred = receiver.xpath('./credentials/credential')[1]
    assert_xpaths_in second_cred,
      [ './name', 'partner_password' ],
      [ './value', 'the_password' ]
  end

  private

  def receiver_test_credentials
    [
      { name: 'partner_id', value: 'the_id', safe: 'true' },
      { name: 'partner_password', value: 'the_password'},
    ]
  end

end
