require 'oauth2'
require 'httparty'
require 'json'
require 'pry'

class TwitterTest
  include HTTParty
  include OAuth2

  consumer_key = ENV["TWITTER_LOCAL_API_KEY"]
  consumer_secret = ENV["TWITTER_LOCAL_API_SECRET"]

  def initialize

  end

end
