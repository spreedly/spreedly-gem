module Spreedly

  class OffsitePurchase < AuthPurchase
    
    field :checkout_url

    def initialize(xml_doc)
      super
      response_xml_doc = xml_doc.at_xpath('.//setup_response')
      @response = response_xml_doc ? SetupResponse.new(response_xml_doc) : nil
    end

    def pending?
      state == 'pending'
    end

  end

  class SetupResponse
    include Fields

    field :success, type: :boolean
    field :created_at, :updated_at, type: :date_time
    field :message, :error_code, :checkout_url

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end

  end

end
