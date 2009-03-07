require 'ostruct'
require 'bigdecimal'

class Spreedly
  def self.configure(name, token)
    @site = MockResource.new '/spreedly'
    MockResource.handle('/spreedly/subscribers', :delete) do |payload|
      MockResource.storage.delete(:subscribers)
    end
    MockResource.handle('/spreedly/subscribers', :post) do |payload|
      subscriber = OpenStruct.new(payload.first[:subscriber])
      subscriber.customer_id = subscriber.customer_id.to_s
      if MockResource.storage[:subscribers][subscriber.customer_id]
        MockResource.request_failed(403)
      elsif subscriber.customer_id == ""
        MockResource.request_failed(422)
      else
        MockResource.storage[:subscribers][subscriber.customer_id] = subscriber
      end
      subscriber.token = "token-for-#{subscriber.customer_id}"
      subscriber.created_at = Time.now
      subscriber.active = false
      subscriber.store_credit = BigDecimal('0.0')
      subscriber
    end
    MockResource.handle('/spreedly/subscribers', :get) do |payload|
      MockResource.storage[:subscribers][payload.first]
    end
  end
  
  def self.process_response(response)
    response
  end
end

class MockResource
  def self.handlers
    @handlers ||= {}
  end
  
  def self.handle(path, method, &block)
    handlers[[path, method.to_s]] = block
  end
  
  def self.storage
    @storage ||= Hash.new{|h,k| h[k] = {}}
  end
  
  def self.request_failed(code)
    response = OpenStruct.new(:code => code)
    raise RestClient::RequestFailed.new(response)
  end
  
  def initialize(path)
    @path = path
  end

  def [](path)
    self.class.new(@path.to_s + '/' + path.to_s)
  end
  
  %w(delete post get put).each do |method|
    define_method(method) do |*payload|
      handler = self.class.handlers[[@path, method]]
      parts = @path.split('/')
      if handler
        handler.call(payload)
      elsif handler = self.class.handlers[[parts[0..-2].join('/'), method]]
        payload.unshift(parts.last)
        handler.call(payload)
      else
        raise "No handler for #{method} on #{@path}"
      end
    end
  end
end