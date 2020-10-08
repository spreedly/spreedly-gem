module Spreedly
  class Response
    include Fields

    field :success, :pending, :cancelled, :fraud_review, type: :boolean
    field :created_at, :updated_at, type: :date_time
    field :message, :avs_code, :avs_message, :cvv_code, :cvv_message, :error_code, :error_detail

    def initialize(xml_doc)
      initialize_fields(xml_doc)
    end
  end
end
