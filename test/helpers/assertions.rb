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

      assert_raise_with_message(Spreedly::AuthenticationError, "Unable to authenticate using the given environment_key and access_token.  Please check your credentials.") do
        yield(environment)
      end
    end

    def assert_xpaths_in(xml_doc, *xpaths)
      xpaths.each do |xpath, expected_text|
        assert_equal expected_text, xml_doc.xpath(xpath).text, "Looking for the text of the following xpath: #{xpath}"
      end
    end

  end


end
