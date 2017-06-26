require 'oauth2'
require 'httparty'
require 'json'
require 'pry'
require 'base64'

class TwitterTest
  include HTTParty
  include OAuth2

  @consumer_key = ENV["TWITTER_LOCAL_API_KEY"]
  @consumer_secret = ENV["TWITTER_LOCAL_API_SECRET"]

  def initialize
    binding.pry

    credentials = Base64.encode64("#{@consumer_key}:#{@consumer_secret}").gsub("\n",'')
    url = "https://api.twitter.com/oauth2/token"
    body = "grant_type=client_credentials"
    headers = {
      "Authorization" => "Basic #{credentials}",
      "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
    }
    binding.pry

    r = HTTParty.post(url, body: body, headers: headers)
    bearer_token = JSON.parse(r.body)['access_token']
    puts "Twitter bearer token is: #{bearer_token}"

    binding.pry

    api_auth_header = {"Authorization" => "Bearer #{bearer_token}"}
    url = "https://api.twitter.com/1.1/search/tweets.json?q=nba"
    puts HTTParty.get(url, headers: api_auth_header).body

  end



end
