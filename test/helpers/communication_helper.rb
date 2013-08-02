module Spreedly

  module CommunicationHelper

    def get_request_body(response)
      remembered_body = nil

      @environment.define_singleton_method(:raw_ssl_request) do |method, enpoint, body, headers|
        remembered_body = body
        response
      end

      yield
      Nokogiri::XML(remembered_body)
    end

  end

end
