require 'rest_client'
require 'nokogiri'
require 'time'
require 'bigdecimal'
require 'delegate'

class Spreedly
  def self.configure(name, token)
    @site = RestClient::Resource.new("https://spreedly.com/api/v4/#{name}", :user => token, :password => 'X')
  end
  
  def self.site
    if @site
      @site
    else
      raise "You must call Spreedly.configure before calling methods."
    end
  end
  
  def self.mock!
    require 'mock_spreedly'
  end
  
  def self.process_response(response)
    XMLResponseData.new(response)
  end
  
  class Subscriber
    def self.subscribers
      @subscribers ||= Spreedly.site['subscribers']
    end

    def self.wipe!
      subscribers.delete
    end

    def self.create!(params={})
      id = params.delete(:id)
      new(Spreedly.process_response(subscribers.post(:subscriber => {:customer_id => id}.merge(params))))
    rescue RestClient::RequestFailed => e
      case e.http_code
      when 422
        raise "Could not create subscriber: validation failed."
      when 403
        raise "Could not create subscriber: already exists."
      else
        raise
      end
    end
    
    def self.find(id)
      new(Spreedly.process_response(subscribers[id.to_s].get))
    end
    
    attr_reader :id
    
    def initialize(data)
      @data = data
      @id = @data.customer_id
    end
    
    def method_missing(*args, &block)
      @data.send(*args, &block)
    end
  end
  
  class XMLResponseData
    def initialize(xml)
      @doc = Nokogiri::XML(xml)
    end
    
    def method_missing(method, *args)
      if args.empty? && node = @doc.at(method.to_s.tr('_', '-'))
        case node['type']
        when 'datetime'
          (node.content == "" ? nil : Time.parse(node.content))
        when 'boolean'
          (node.content == "true")
        when 'decimal'
          BigDecimal(node.content)
        else
          node.content
        end
      else
        super
      end
    end
  end
end