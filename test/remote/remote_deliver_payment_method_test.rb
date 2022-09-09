require 'test_helper'

class RemoteDeliverPaymentMethodTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.deliver_to_receiver('rtoken', 'ptoken', headers: headers, url: url, body: receiver_body)
    end
  end

  def test_payment_method_not_found
    receiver_token = @environment.add_receiver(:test, url).token
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified payment method.") do
      @environment.deliver_to_receiver(receiver_token, 'unknown_payment_method',
                                       headers: headers, url: url, body: receiver_body)
    end
  end

  def test_receiver_not_found
    card_token = create_card_on(@environment).token
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified receiver.") do
      @environment.deliver_to_receiver('unknown_receiver', card_token,
                                       headers: headers, url: url, body: receiver_body)
    end
  end

  def test_successfully_deliver_receiver
    receiver_token = @environment.add_receiver(:test, url, receiver_test_credentials).token
    card_token = create_card_on(@environment).token

    transaction = @environment.deliver_to_receiver(receiver_token, card_token,
                                                   headers: headers, url: url, body: receiver_body)

    assert_equal(true, transaction.succeeded?)
    assert_equal(card_token, transaction.payment_method.token)
    assert_equal(receiver_token, transaction.receiver.token)
    assert_equal('200', transaction.response.status)
    assert_match(/Server: Spreedly Echo Server/, transaction.response.headers)
    assert_match(/CONNECTION: close/, transaction.response.headers)
    
  end

  private
  def headers
    { 'Content-Type' => 'application/json' }
  end

  def url
    'https://spreedly-echo.herokuapp.com'
  end

  def receiver_test_credentials
    [
      { name: 'user_name', value: 'test_user', safe: 'true' },
      { name: 'secret_password', value: 'qAAJ6yWN'}
    ]
  end

  def receiver_body
    '{"product_id":"916593","card_number":"{{ credit_card_number }}","user_name":"{{user_name}}","secret_password":"{{secret_password}}"}'
  end
end
