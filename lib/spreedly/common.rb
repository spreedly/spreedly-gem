Dir[File.dirname(__FILE__) + '/../../vendor/*'].each do |directory|
  next unless File.directory?(directory)
  $LOAD_PATH.unshift File.expand_path(directory + '/lib')
end

require 'uri'
require 'bigdecimal'

require 'spreedly/version'

module Spreedly
  # Generates a subscribe url for the given user id and plan.
  def self.subscribe_url(id, plan, screen_name=nil)
    screen_name = (screen_name ? URI.escape(screen_name) : "")
    "https://spreedly.com/#{site_name}/subscribers/#{id}/subscribe/#{plan}/#{screen_name}"
  end
  
  # Generates a subscribe url for the given user id and plan. Pre-Populated with the given email, first and last names
  def self.pre_populated_subscribe_url(id, plan, email, first_name, last_name)
    email = (email ? URI.escape(email) : "")
    first_name = (first_name ? URI.escape(first_name) : "")
    last_name = (last_name ? URI.escape(last_name) : "")
    "https://spreedly.com/#{site_name}/subscribers/#{id}/subscribe/#{plan}?email=#{email}&first_name=#{first_name}&last_name=#{last_name}"
  end
  
  # Generates an edit subscriber for the given subscriber token. The
  # token is returned with the subscriber info (i.e. by
  # Subscriber.find).
  def self.edit_subscriber_url(token)
    "https://spreedly.com/#{site_name}/subscriber_accounts/#{token}"
  end
end
