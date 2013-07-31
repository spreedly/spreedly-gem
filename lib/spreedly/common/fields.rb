module Spreedly
  module Fields

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def field(*fields_to_add)
        @fields ||= []
        fields_to_add.each do |f|
          @fields += [ f ]
          attr_reader f
        end
      end

      def fields
        @fields ||= []
      end

      def inherited(subclass)
        subclass.instance_variable_set("@fields", instance_variable_get("@fields"))
      end
    end

    def field_hash
      self.class.fields.inject({}) do |each, hash|
        hash[each] = send(each)
      end
    end

    def initialize_fields(xml_doc)
      self.class.fields.each do |field|
        instance_variable_set("@#{field}", xml_doc.at_xpath("//#{field}").inner_html.strip)
      end
    end

  end
end
