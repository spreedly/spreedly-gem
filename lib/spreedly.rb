require 'spreedly/common'
require 'httparty'

raise "Mock Spreedly already required!" if defined?(Spreedly::MOCK)

=begin rdoc
Provides a convenient wrapper around the http://spreedly.com API.
Instead of mucking around with http you can just Spreedly.configure
and Spreedly::Subscriber.find. Much of the functionality is hung off
of the Spreedly::Subscriber class, and there's also a
Spreedly::SubscriptionPlan class.

One of the goals of this wrapper is to keep your tests fast while
also keeping your app working. It does this by providing a drop-in
replacement for the real Spreedly functionality that skips the
network and gives you a simple (some might call it stupid)
implementation that will work for 90% of your tests. At least we
hope so.

Help us make the mock work better by telling us when it doesn't work
so we can improve it. Thanks!

==Example mock usage:

  if ENV["SPREEDLY"] == "REAL"
    require 'spreedly'
  else
    require 'spreedly/mock'
  end
=end

module Spreedly
  REAL = "real" # :nodoc:

  include HTTParty
  headers 'Accept' => 'text/xml'
  headers 'Content-Type' => 'text/xml'
  format :xml

  # Call this before you start using the API to set things up.
  def self.configure(site_name, token)
    base_uri "https://spreedly.com/api/v4/#{site_name}"
    basic_auth token, 'X'
    @site_name = site_name
  end
  
  def self.site_name # :nodoc:
    @site_name
  end
  
  def self.to_xml_params(hash) # :nodoc:
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
  
  class Resource # :nodoc: all
    def initialize(data)
      @data = data
    end
    
    def id
      @data["id"]
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

    # This will DELETE all the subscribers from the site.
    #
    # Only works for test sites (enforced on the Spreedly side).
    def self.wipe!
      Spreedly.delete('/subscribers.xml')
    end
    
    # This will DELETE individual subscribers from the site. Pass in the customer_id.
    # 
    # Only works for test sites (enforced on the Spreedly side).
    def self.delete!(id)
      Spreedly.delete("/subscribers/#{id}.xml")
    end

    # Creates a new subscriber on Spreedly. The subscriber will NOT
    # be active - they have to pay or you have to comp them for that
    # to happen.
    #
    # Usage:
    #   Spreedly.Subscriber.create!(id, email)
    #   Spreedly.Subscriber.create!(id, email, screen_name)
    #   Spreedly.Subscriber.create!(id, :email => email, :screen_name => screen_name)
    #   Spreedly.Subscriber.create!(id, email, screen_name, :billing_first_name => first_name)
    def self.create!(id, *args)
      optional_attrs = args.last.is_a?(::Hash) ? args.pop : {}
      email, screen_name = args
      subscriber = {:customer_id => id, :email => email, :screen_name => screen_name}.merge(optional_attrs)
      result = Spreedly.post('/subscribers.xml', :body => Spreedly.to_xml_params(:subscriber => subscriber))
      case result.code.to_s
      when /2../
        new(result['subscriber'])
      when '403'
        raise "Could not create subscriber: already exists."
      when '422'
        errors = [*result['errors']].collect{|e| e.last}
        raise "Could not create subscriber: #{errors.join(', ')}"
      else
        raise "Could not create subscriber: result code #{result.code}."
      end
    end
    
    # Looks a subscriber up by id.
    def self.find(id)
      xml = Spreedly.get("/subscribers/#{id}.xml")
      (xml.nil? || xml.empty? ? nil : new(xml['subscriber']))
    end
    
    # Returns all the subscribers in your site.
    def self.all
      Spreedly.get('/subscribers.xml')['subscribers'].collect{|data| new(data)}
    end
    
    # Spreedly calls your id for the user the "customer id". This
    # gives you a handy alias so you can just call it "id".
    def id
      customer_id
    end
    
    # Allows you to give a complimentary subscription (if the
    # subscriber is inactive) or a complimentary time extension (if
    # the subscriber is active). Automatically figures out which
    # to do.
    #
    # Note: units must be one of "days" or "months" (Spreedly
    # enforced).
    def comp(quantity, units, feature_level=nil)
      params = {:duration_quantity => quantity, :duration_units => units}
      params[:feature_level] = feature_level if feature_level
      endpoint = (active? ? "complimentary_time_extensions" : "complimentary_subscriptions")
      result = Spreedly.post("/subscribers/#{id}/#{endpoint}.xml", :body => Spreedly.to_xml_params(endpoint[0..-2] => params))
      case result.code.to_s
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
    
    # Activates a free trial on the subscriber.
    # Requires plan_id of the free trial plan
    def activate_free_trial(plan_id)
      result = Spreedly.post("/subscribers/#{id}/subscribe_to_free_trial.xml", :body => 
        Spreedly.to_xml_params(:subscription_plan => {:id => plan_id}))
      case result.code.to_s
      when /2../
      when '404'
        raise "Could not active free trial for subscriber: subscriber or subscription plan no longer exists."
      when '422'
        raise "Could not activate free trial for subscriber: validation failed. missing subscription plan id"
      when '403'
        raise "Could not activate free trial for subscriber: subscription plan either 1) isn't a free trial, 2) the subscriber is not eligible for a free trial, or 3) the subscription plan is not enabled."
      else
        raise "Could not activate free trial for subscriber: result code #{result.code}."
      end
    end
    
    # Stop the auto renew of the subscriber such that their recurring subscription will no longer be renewed.
    # usage: @subscriber.stop_auto_renew
    def stop_auto_renew
      result = Spreedly.post("/subscribers/#{id}/stop_auto_renew.xml")
      case result.code.to_s
      when /2../
      when '404'
        raise "Could not stop auto renew for subscriber: subscriber does not exist."
      else
        raise "Could not stop auto renew for subscriber: result code #{result.code}."
      end
    end
    
  end
  
  class SubscriptionPlan < Resource
    # Returns all of the subscription plans defined in your site.
    def self.all
      Spreedly.get('/subscription_plans.xml')['subscription_plans'].collect{|data| new(data)}
    end

    # Returns the subscription plan with the given id.
    def self.find(id)
      all.detect{|e| e.id.to_s == id.to_s}
    end
    
    # Convenience method for determining if this plan is a free trial plan or not.
    def trial?
      (plan_type == 'free_trial')
    end
  end
end
