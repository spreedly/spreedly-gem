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
      when 401
        raise AuthenticationError.new
      when 404
        raise NotFoundError.new(parse_xml(response.body)[:error])
      else
        raise ResponseError.new(response)
      end
    end

    def parse_xml(xml)
      hash = {}

      doc = Nokogiri::XML(xml)
      doc.root.xpath('*').each do |node|
        if (node.elements.empty?)
          hash[node.name.downcase.to_sym] = node.text
        else
          hash[node.name.downcase.to_sym] = node.elements.to_s
        end
      end

      hash
    end


  end

end
