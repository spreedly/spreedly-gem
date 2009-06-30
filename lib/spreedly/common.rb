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
  
  # Generates an edit subscriber for the given subscriber token. The
  # token is returned with the subscriber info (i.e. by
  # Subscriber.find).
  def self.edit_subscriber_url(token)
    "https://spreedly.com/#{site_name}/subscriber_accounts/#{token}"
  end
end
