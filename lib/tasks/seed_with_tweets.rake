namespace :db do
  desc "Seed database with tweets based on every region"
  task :seed_with_tweets => :environment do
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV["API_KEY"]
      config.consumer_secret     = ENV["API_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
    
    sf = "-122.75,36.8,-121.75,37.8"
    # all = "-180, -90, 180, 90"
    
    #join all regions together via commas 
    #with sw_corner, ne_corner long/lat pairs 
    
    client.filter(:locations => sf) do |object|
      if object.is_a?(Twitter::Tweet)
        puts object.text
        puts object.created_at

        Tweet.generate_tweet(object.text, object.geo, object.created_at)
      end
    end
  end
end