require 'httparty'

require 'spreedly/common'

raise "Mock Spreedly already required!" if defined?(Spreedly::MOCK)

class Spreedly
  REAL = "real"

  include HTTParty
  headers 'Accept' => 'text/xml'
  headers 'Content-Type' => 'text/xml'
  format :xml

  def self.configure(name, token)
    base_uri "https://spreedly.com/api/v4/#{name}"
    basic_auth token, 'X'
    @site_name = name
  end
  
  def self.site_name
    @site_name
  end
  
  def self.to_xml_params(hash)
    hash.collect do |key, value|
      tag = key.to_s.tr('_', '-')
      result = "<#{tag}>"
      if value.is_a?(Hash)
        result << to_xml_params(value)
      else
        result << value.to_s
      end
      result << "</#{tag}>"
      result
    end.join('')
  end
  
  class Resource
    def initialize(data)
      @data = data
    end
    
    def method_missing(method, *args, &block)
      if method.to_s =~ /\?$/
        send(method.to_s[0..-2])
      elsif @data.include?(method.to_s)
        @data[method.to_s]
      else
        super
      end
    end
  end

  class Subscriber < Resource
    def self.wipe!
      Spreedly.delete('/subscribers.xml')
    end

    def self.create!(params={})
      params = params.dup
      params[:customer_id] = params.delete(:id)
      result = Spreedly.post('/subscribers.xml', :body => Spreedly.to_xml_params(:subscriber => params))
      case result.code
      when /2../
        new(result['subscriber'])
      when '403'
        raise "Could not create subscriber: no id passed OR already exists."
      else
        raise "Could not create subscriber: result code #{result.code}."
      end
    end
    
    def self.find(id)
      new(Spreedly.get("/subscribers/#{id}.xml")['subscriber'])
    end
    
    def self.all
      Spreedly.get('/subscribers.xml')['subscribers'].collect{|data| new(data)}
    end
    
    def id
      customer_id
    end
    
    def comp(params={})
      endpoint = (active? ? "complimentary_time_extensions" : "complimentary_subscriptions")
      result = Spreedly.post("/subscribers/#{id}/#{endpoint}.xml", :body => Spreedly.to_xml_params(endpoint[0..-2] => params))
      case result.code
      when /2../
      when '404'
        raise "Could not comp subscriber: no longer exists."
      when '422'
        raise "Could not comp subscriber: validation failed."
      when '403'
        raise "Could not comp subscriber: invalid comp type (#{endpoint})."
      else
        raise "Could not comp subscriber: result code #{result.code}."
      end
    end
  end
  
  class SubscriptionPlan < Resource
    def self.all
      Spreedly.get('/subscription_plans.xml')['subscription_plans'].collect{|data| new(data)}
    end
  end
end