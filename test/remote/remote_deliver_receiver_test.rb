require 'test_helper'
require 'json'

class RemoteDeliverReceiverTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_successfully_deliver_receiver
    receiver = @environment.add_receiver(:test, url, receiver_test_credentials)

    t = @environment.add_credit_card(card_deets)

    card_token = t.payment_method.token

    transaction = @environment.deliver_receiver(
        receiver_token: receiver.token,
        payment_method_token: card_token,
        receiver_headers: headers,
        url: url,
        receiver_body: receiver_body)

    assert_equal(true, transaction.succeeded?)
    assert_match('Successfully dumped 0 post variables', transaction.response.body, )
  end

  private

  def receiver_test_credentials
    [
    { name: 'user_name', value: 'test_user', safe: 'true' },
    { name: 'secret_password', value: 'qAAJ6yWN'}
    ]
  end

  def card_deets(options = {})
    {
      email: 'perrin@wot.com', number: '4111111111111111', month: 1, year: 2019, verification_value: 123,
      last_name: 'Aybara', first_name: 'Perrin'
    }.merge(options)
  end

  def headers
    {
      'Host' => 'https://api-sandbox.networkforgood.org',
      'Content-Length' => 1024,
      'Content-Type' => 'application/json'
    }
  end

  def url
    'http://posttestserver.com/post.php'
  end

  def receiver_body
    {"product_id" => "916593",
        "card_number" => "{{ credit_card_number }}",
        "user_name" => "{{user_name}}",
        "secret_password" => "{{secret_password}}"}.to_json
  end
end
