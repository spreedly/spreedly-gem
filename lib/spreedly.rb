require 'rest_client'
require 'nokogiri'
require 'time'
require 'bigdecimal'
require 'uri'

raise "Mock Spreedly already required!" if defined?(Spreedly::MOCK)

class Spreedly
  REAL = "real"
  def self.configure(name, token)
    @name = name
    @site = Resource.new("https://spreedly.com/api/v4/#{name}", :user => token, :password => 'X', :headers => {'Content-Type' => 'text/xml', 'Accept' => 'text/xml'})
  end
  
  def self.site
    if @site
      @site
    else
      raise "You must call Spreedly.configure before calling methods."
    end
  end
  
  def self.name
    @name
  end
  
  def self.process_response(response)
    XMLResponseData.new(Nokogiri::XML(response))
  end
  
  def self.subscribe_url(params)
    screen_name = (params[:screen_name] ? URI.escape(params[:screen_name]) : "")
    "https://spreedly.com/#{name}/subscribers/#{params[:id]}/subscribe/#{params[:plan]}/#{screen_name}"
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
    
    def self.all
      Spreedly.process_response(subscribers.get).subscribers.collect{|data| new(data)}
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
  
  class Resource < RestClient::Resource
    def url
      @url + '.xml'
    end
    def [](suburl)
      self.class.new(concat_urls(@url, suburl), options)
    end
  end

  class XMLResponseData
    def initialize(parsed_xml)
      @doc = parsed_xml
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
        when 'array'
          node.children.reject{|e| e.text?}.collect{|e| XMLResponseData.new(e)}
        else
          node.content
        end
      else
        super
      end
    end
  end
end