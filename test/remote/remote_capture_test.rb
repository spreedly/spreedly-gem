require 'test_helper'

class RemoteCaptureTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.capture_transaction('authorize_token')
    end
  end

  def test_authorization_token_found
    assert_raise_with_message(Spreedly::NotFoundError, "Unable to find the specified reference transaction.") do
      @environment.capture_transaction('unknown_auth_token')
    end
  end

  def test_needs_succeeded_reference
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_failed_card_on(@environment).token
    authorization = @environment.authorize_on_gateway(gateway_token, card_token, 144)
    assert !authorization.succeeded?

    assert_raise_with_message(Spreedly::TransactionCreationError, "The reference transaction did not succeed. Only successful reference transactions are permitted.") do
      @environment.capture_transaction(authorization.token)
    end
  end

  def test_successful_capture_full_amount
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    authorization = @environment.authorize_on_gateway(gateway_token, card_token, 800)
    assert authorization.succeeded?

    capture = @environment.capture_transaction(authorization.token)
    assert capture.succeeded?
    assert_equal authorization.token, capture.reference_token
    assert_equal 800, capture.amount
  end

  def test_successful_capture_partial_amount
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token

    authorization = @environment.authorize_on_gateway(gateway_token, card_token, 800)
    assert authorization.succeeded?

    capture = @environment.capture_transaction(authorization.token, amount: 322)
    assert capture.succeeded?
    assert_equal authorization.token, capture.reference_token
    assert_equal 322, capture.amount
  end

  def test_failed_capture
    gateway_token = @environment.add_gateway(:test).token
    card_token = create_card_on(@environment).token
    authorization = @environment.authorize_on_gateway(gateway_token, card_token, 800)
    assert authorization.succeeded?

    capture = @environment.capture_transaction(authorization.token, amount: 44)
    assert !capture.succeeded?
    assert_equal authorization.token, capture.reference_token
    assert_equal 44, capture.amount
    assert_equal 'Unable to process the capture transaction.', capture.message
  end

end
