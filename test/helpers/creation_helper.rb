
module Spreedly

  module CreationHelper

    def create_card_on(environment, options = {})
      deets = default_card_deets.merge(options)
      environment.add_credit_card(deets).payment_method
    end

    def create_failed_card_on(environment, options = {})
      deets = default_card_deets.merge(number: '4012888888881881').merge(options)
      environment.add_credit_card(deets).payment_method
    end

    def create_sprel_on(environment)
      body = default_sprel_body(environment)
      redirect_html = raw_ssl_request(:post, environment.transparent_redirect_form_action, body, {}).body
      redirect_html.match(/token=(\w+)/)[1]
    end

    private

    def default_card_deets
      {
        email: 'perrin@wot.com', number: '5555555555554444', month: 1, year: 2023,
        last_name: 'Aybara', first_name: 'Perrin', retained: true
      }
    end

    def default_sprel_body(environment)
      {
        environment_key: environment.key,
        redirect_url: "http://example.com/transparent_redirect_complete",
        payment_method_type: "sprel"
      }.map do |key, value|
        "#{key}=#{CGI.escape(value.to_s)}"
      end.compact.join("&")
    end

    def raw_ssl_request(method, endpoint, body, headers, options = {})
      raw_response = Timeout::timeout(60) do
        connection = Spreedly::Connection.new(endpoint)
        connection.request(method, body, headers)
      end

      raw_response
    end
  end
end
