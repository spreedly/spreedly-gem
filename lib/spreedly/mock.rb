require 'spreedly/common'

raise "Real Spreedly already required!" if defined?(Spreedly::REAL)

module Spreedly
  MOCK = "mock"
  
  def self.configure(name, token)
    @site_name = name
  end
  
  def self.site_name
    @site_name
  end
  
  class Resource
    def self.attributes
      @attributes ||= {}
    end

    def self.attributes=(value)
      @attributes = value
    end
    
    def initialize(params={})
      @attributes = self.class.attributes.inject({}){|a,(k,v)| a[k.to_sym] = v.call; a}
      params.each {|k,v| @attributes[k.to_sym] = v }
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
  
  class Subscriber < Resource
    self.attributes = {
      :created_at => proc{Time.now},
      :token => proc{(rand * 1000).round},
      :active => proc{false},
      :store_credit => proc{BigDecimal("0.0")},
      :active_until => proc{nil},
      :feature_level => proc{""},
      :on_trial => proc{false},
      :recurring => proc{false}
    }

    def self.wipe! # :nodoc: all
      @subscribers = nil
    end
    
    def self.create!(id, *args) # :nodoc: all
      optional_attrs = args.last.is_a?(::Hash) ? args.pop : {}
      email, screen_name = args
      sub = new({:customer_id => id, :email => email, :screen_name => screen_name}.merge(optional_attrs))

      if subscribers[sub.id]
        raise "Could not create subscriber: already exists."
      end

      subscribers[sub.id] = sub
      sub
    end
    
    def self.delete!(id)
      subscribers.delete(id)
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
      super
      if !id || id == ''
        raise "Could not create subscriber: Customer ID can't be blank."
      end
    end
    
    def id
      @attributes[:customer_id]
    end
    
    def comp(quantity, units, feature_level=nil)
      raise "Could not comp subscriber: no longer exists." unless self.class.find(id)
      raise "Could not comp subscriber: validation failed." unless units && quantity
      current_active_until = (active_until || Time.now)
      @attributes[:active_until] = case units
      when 'days'
        current_active_until + (quantity.to_i * 86400)
      when 'months'
        current_active_until + (quantity.to_i * 30 * 86400)
      end
      @attributes[:feature_level] = feature_level if feature_level
      @attributes[:active] = true
    end

    def activate_free_trial(plan_id)
      raise "Could not activate free trial for subscriber: validation failed. missing subscription plan id" unless plan_id
      raise "Could not active free trial for subscriber: subscriber or subscription plan no longer exists." unless self.class.find(id) && SubscriptionPlan.find(plan_id)
      raise "Could not activate free trial for subscriber: subscription plan either 1) isn't a free trial, 2) the subscriber is not eligible for a free trial, or 3) the subscription plan is not enabled." if on_trial?
      @attributes[:on_trial] = true
      plan = SubscriptionPlan.find(plan_id)
      comp(plan.duration_quantity, plan.duration_units, plan.feature_level)
    end

    def stop_auto_renew
      raise "Could not stop auto renew for subscriber: subscriber does not exist." unless self.class.find(id)
      @attributes[:recurring] = false
    end
    
    def subscribe(plan_id)
      @attributes[:recurring] = true
      plan = SubscriptionPlan.find(plan_id)
      comp(plan.duration_quantity, plan.duration_units, plan.feature_level)
    end
  end
  
  class SubscriptionPlan < Resource
    self.attributes = {
      :plan_type => proc{'regular'},
      :feature_level => proc{''}
    }
    
    def self.all
      plans.values
    end
    
    def self.find(id)
      plans[id.to_i]
    end
    
    def self.plans
      @plans ||= {
        1 => new(:id => 1, :name => 'Default mock plan', :duration_quantity => 1, :duration_units => 'days'),
        2 => new(:id => 2, :name => 'Test Free Trial Plan', :plan_type => 'free_trial', :duration_quantity => 1, :duration_units => 'days'),
        3 => new(:id => 3, :name => 'Test Regular Plan', :duration_quantity => 1, :duration_units => 'days'),
      }
    end
    
    def trial?
      (plan_type == "free_trial")
    end
  end
end