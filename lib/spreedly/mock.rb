require 'spreedly/common'

raise "Real Spreedly already required!" if defined?(Spreedly::REAL)

class Spreedly
  MOCK = "mock"
  
  def self.configure(name, token)
    @site_name = name
  end
  
  def self.site_name
    @site_name
  end
  
  class Subscriber
    ATTRIBUTES = {
      :created_at => proc{Time.now},
      :token => proc{(rand * 1000).round},
      :active => proc{false},
      :store_credit => proc{BigDecimal("0.0")},
      :active_until => proc{nil},
      :feature_level => proc{""},
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
    
    def comp(params={})
      raise "Could not comp subscriber: no longer exists." unless self.class.find(id)
      raise "Could not comp subscriber: validation failed." unless params.include?(:duration_units) && params.include?(:duration_quantity)
      current_active_until = (active_until || Time.now)
      @attributes[:active_until] = case params[:duration_units]
      when 'days'
        current_active_until + (params[:duration_quantity].to_i * 86400)
      when 'months'
        current_active_until + (params[:duration_quantity].to_i * 30 * 86400)
      end
      @attributes[:feature_level] = params[:feature_level]
      @attributes[:active] = true
    end
    
    def id
      @attributes[:id]
    end
    
    def method_missing(method, *args)
      if method.to_s =~ /\?$/
        send(method.to_s[0..-2], *args)
      elsif @attributes.include?(method)
        @attributes[method]
      else
        super
      end
    end
  end
end