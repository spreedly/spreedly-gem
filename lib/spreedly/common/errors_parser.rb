module Spreedly
  module ErrorsParser

    def errors_from(xml_doc)
      xml_doc.xpath(".//errors/error").map do |each|
        {
          attribute: each.attributes['attribute'].to_s,
          key: each.attributes['key'].to_s,
          message: each.text
        }
      end
    end

  end
end
