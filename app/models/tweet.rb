class Tweet < ActiveRecord::Base
  delegate :x, :to => :location, :allow_nil => true
  delegate :y, :to => :location, :allow_nil => true
  # delegate :srid, :to => :location, :allow_nil => true
  
  validates :x, :y, :body, :interval, :presence => true
  validates :x, :numericality => 
    { :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180 }
  validates :y, :numericality => 
    { :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90 }
  
  def self.generate_tweet(text, geo, created_at)
    point = "SRID=4326;POINT(#{geo.long} #{geo.lat})"
    interval = Tweet.round_to_2_minutes(created_at)
    
    Tweet.create(:body => text, :location => point, :interval => interval)
  end
  
  private
  
  def self.round_to_2_minutes(t)
    rounded = Time.at((t.to_time.to_i / 120.0).round * 120)
    t.is_a?(DateTime) ? rounded.to_datetime : rounded
  end
end
