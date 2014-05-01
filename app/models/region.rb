class Region < ActiveRecord::Base
  #add check to verify long/lat corners entered correctly
  validates :name, :long_lat_corner_pairs, :bounding_box, :presence => true
  
  def self.generate_region(text, sw_corner, ne_corner)
    polygon = Region.create_bounding_box(sw_corner, ne_corner)
    
    corner_pairs = sw_corner[0].to_s + "," +
                   sw_corner[1].to_s + "," +
                   ne_corner[0].to_s + "," +
                   ne_corner[1].to_s
    
    Region.create(
      :name => text, 
      :long_lat_corner_pairs => corner_pairs, 
      :bounding_box => polygon
    )
  end
  
  def intervals_with_tweet_counts
    Tweet.where('ST_Contains(?, tweets.location)', self.bounding_box)
         .group(:interval)
         .order("interval DESC")
         .limit(30)
         .count
  end
  
  private
  
  def self.create_bounding_box(sw_corner, ne_corner)
    "SRID=4326;POLYGON((" + 
      "#{sw_corner[0]} #{sw_corner[1]}," +
      "#{sw_corner[0]} #{ne_corner[1]}," +
      "#{ne_corner[0]} #{ne_corner[1]}," +
      "#{ne_corner[0]} #{sw_corner[1]}," +
      "#{sw_corner[0]} #{sw_corner[1]}"  + 
    "))"
  end
end
