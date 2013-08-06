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

    def get_request_url(response)
      remembered_url = nil

      @environment.define_singleton_method(:raw_ssl_request) do |method, endpoint, body, headers|
        remembered_url = endpoint
        response
      end

      yield
      remembered_url
    end

  end

end
