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
      xml_doc = Nokogiri::XML(response.body)

      case response.code.to_i
      when 200...300
        xml_doc
      when 401
        raise AuthenticationError.new
      when 404
        raise NotFoundError.new(error_from(xml_doc))
      when 402
        raise PaymentRequiredError.new(error_from(xml_doc))
      when 422
        if xml_doc.at_xpath('//error')
          raise TraansactionCreationError.new(error_from(xml_doc))
        else
          xml_doc
        end
      else
        raise UnexpectedResponseError.new(response)
      end
    end

    def error_from(xml_doc)
      xml_doc.xpath('//error').inner_text
    end

  end

end
