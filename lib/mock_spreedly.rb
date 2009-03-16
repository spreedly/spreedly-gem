require 'ostruct'
require 'bigdecimal'

raise "Real Spreedly already required!" if defined?(Spreedly::REAL)

class Spreedly
  MOCK = "mock"
  
  def self.configure(name, token)
  end
  
  class Subscriber
    ATTRIBUTES = {
      :created_at => proc{Time.now},
      :token => proc{(rand * 1000).round},
      :active => proc{false},
      :store_credit => proc{BigDecimal("0.0")},
      :active_until => proc{nil},
    }

    def self.wipe!
      @subscribers = nil
    end
    
    def self.create!(params={})
      sub = new(params)

      if subscribers[sub.id]
        raise "Could not create subscriber: already exists."
      end

      subscribers[sub.id] = sub
      sub
    end
    
    def self.find(id)
      subscribers[id]
    end
    
    def self.subscribers
      @subscribers ||= {}
    end
    
    def self.all
      @subscribers.values
    end
    
    def initialize(params={})
      @attributes = params
      if !id || id == ''
        raise "Could not create subscriber: validation failed."
      end
      ATTRIBUTES.each{|k,v| @attributes[k] = v.call}
    end
    
    def id
      @attributes[:id]
    end
    
    def method_missing(method, *args)
      if @attributes.include?(method)
        @attributes[method]
      else
        super
      end
    end
  end
end