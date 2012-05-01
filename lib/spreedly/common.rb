Dir[File.dirname(__FILE__) + '/../../vendor/*'].each do |directory|
  next unless File.directory?(directory)
  $LOAD_PATH.unshift File.expand_path(directory + '/lib')
end

require 'uri'
require 'bigdecimal'
require 'cgi'

require 'spreedly/version'

module Spreedly
  # Generates a subscribe url for the given user id and plan.
  # Options:
  #   :screen_name => a screen name for the user (shows up in the admin UI)
  #   :email => pre-populate the email field
  #   :first_name => pre-populate the first name field
  #   :last_name => pre-populate the last name field
  def self.subscribe_url(id, plan, options={})
    %w(screen_name email first_name last_name return_url).each do |option|
      options[option.to_sym] &&= URI.escape(options[option.to_sym])
    end

    screen_name = options.delete(:screen_name)
    params = %w(email first_name last_name return_url).select{|e| options[e.to_sym]}.collect{|e| "#{e}=#{CGI::escape(options[e.to_sym])}"}.join('&')

    url = "https://spreedly.com/#{site_name}/subscribers/#{id}/subscribe/#{plan}"
    url << "/#{screen_name}" if screen_name
    url << '?' << params unless params == ''

    url
  end
  
  # Generates an edit subscriber for the given subscriber token. The
  # token is returned with the subscriber info (i.e. by
  # Subscriber.find).
  def self.edit_subscriber_url(token, return_url = nil)
    "https://spreedly.com/#{site_name}/subscriber_accounts/#{token}" +
        if return_url
            "?return_url=#{URI.escape(return_url)}"
        else
            ''
        end
  end
end
