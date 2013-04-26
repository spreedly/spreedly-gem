module Spreedly

  module SslRequester

    def ssl_get(endpoint, headers = {})
      ssl_request(:get, endpoint, nil, headers)
    end

    def ssl_post(endpoint, body, headers = {})
      ssl_request(:post, endpoint, body, headers)
    end

    def ssl_put(endpoint, body, headers = {})
      ssl_request(:put, endpoint, body, headers)
    end

    private
    def ssl_request(method, endpoint, body, headers)
      handle_response(raw_ssl_request(method, endpoint, body, headers))
    end

    def raw_ssl_request(method, endpoint, body, headers = {})
      connection = Spreedly::Connection.new(endpoint)
      connection.request(method, body, headers)
    end

    def handle_response(response)
      case response.code.to_i
      when 200...300
        response.body
      else
        raise ResponseError.new(response)
      end
    end

  end

end
