require 'uri'
require 'bigdecimal'
require 'spreedly/version'

module Spreedly
  def self.subscribe_url(params)
    screen_name = (params[:screen_name] ? URI.escape(params[:screen_name]) : "")
    "https://spreedly.com/#{site_name}/subscribers/#{params[:id]}/subscribe/#{params[:plan]}/#{screen_name}"
  end
  
  def self.edit_subscriber_url(token)
    "https://spreedly.com/#{site_name}/subscriber_accounts/#{token}"
  end
end