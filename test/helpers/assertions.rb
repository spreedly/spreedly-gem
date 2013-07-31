module Spreedly

  module Assertions

    def assert_raise_with_message(expected_exception_type, expected_message)
      error = assert_raises(expected_exception_type) do
        yield
      end

      assert_equal expected_message, error.message, "Exception message is incorrect"
    end

    def assert_invalid_login
      environment = Spreedly::Environment.new("UnknownEnvironmentKey", "UnknownAccessSecret")

      assert_raise_with_message(Spreedly::AuthenticationError, "Unable to authenticate using the given access_token.") do
        yield(environment)
      end
    end

  end


end
