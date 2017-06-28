require 'httparty'
require 'json'
require 'pry'

class TwitterTest
  include HTTParty

  @@consumer_key = ENV["TWITTER_LOCAL_API_KEY"]
  @@consumer_secret = ENV["TWITTER_LOCAL_API_SECRET"]
  @array = []

  def initialize(search_topic)

    bearer_token = TwitterTest.twitterAuthentication
    date = Time.new
    date = date.strftime("%Y-%m-%d")

    api_auth_header = {"Authorization" => "Bearer #{bearer_token}"}
    url = "https://api.twitter.com/1.1/search/tweets.json?q=#{search_topic}&since:#{date}&result_type=recent"
    @results = HTTParty.get(url, headers: api_auth_header)
    @array = []
    @results.each do |x|
      @array << x
    end

  end

  def TwitterTest.twitterAuthentication

    credentials = Base64.encode64("#{@@consumer_key}:#{@@consumer_secret}").gsub("\n",'')
    url = "https://api.twitter.com/oauth2/token"
    body = "grant_type=client_credentials"
    headers = {
      "Authorization" => "Basic #{credentials}",
      "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
    }

    r = HTTParty.post(url, body: body, headers: headers)
    bearer_token = JSON.parse(r.body)['access_token']
    return bearer_token

  end



end
