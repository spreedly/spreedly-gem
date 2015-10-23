require 'test_helper'

class RemoteAddOffsiteMethodTest < Test::Unit::TestCase

  def setup
    @environment = Spreedly::Environment.new(remote_test_environment_key, remote_test_access_secret)
  end

  def test_invalid_login
    assert_invalid_login do |environment|
      environment.add_offsite_method(offsite_data)
    end
  end

  # Can't seem to get any failing validation errors when creating a Sprel payment method
  #def test_failed_with_validation_errors
  #  error = assert_raises(Spreedly::TransactionCreationError) do
  #    @environment.add_offsite_method(offsite_data(email: ''))
  #  end

  #  expected_errors = [
  #    { attribute: "email", key: "errors.blank", message: "Email can't be blank" }
  #  ]

  #  assert_equal expected_errors, error.errors
  #  assert_equal "Email can't be blank", error.message
  #end

  def test_successful_add_offsite
    t = @environment.add_offsite_method(offsite_data)

    assert t.succeeded?
    assert_equal 'me@joey.io', t.payment_method.email
    assert !t.retained
    assert_equal 'cached', t.payment_method.storage_state
    assert_equal 'foo: bar', t.payment_method.data
  end

  def test_successfully_retain_on_create
    t = @environment.add_offsite_method(offsite_data(retained: true))

    assert t.succeeded?
    assert t.retained
    assert_equal 'retained', t.payment_method.storage_state
  end


  private
  def offsite_data(options = {})
    {
      email: 'me@joey.io', data: "foo: bar", payment_method_type: "sprel"
    }.merge(options)
  end

end
