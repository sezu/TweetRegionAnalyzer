require 'spec_helper'

describe Tweet do
  before(:each) do
    point = "SRID=4326;POINT(50 50)"
    interval = Tweet.round_to_2_minutes(DateTime.now)
    @tweet = Tweet.new(:body => "test", :location => point, :interval => interval)
  end
  
  context "validations" do    
    it "should be invalid without text" do
      @tweet.body = nil
      @tweet.should_not be_valid
    end
    
    it "should be invalid without location" do
      @tweet.location = nil
      @tweet.should_not be_valid
    end
    
    it "should be invalid without interval" do
      @tweet.interval = nil
      @tweet.should_not be_valid
    end
    
    it "should be invalid if out of longitude bounds ( < -180 )" do
      point = "SRID=4326;POINT(-181 50)"
      @tweet.location = point
      @tweet.should_not be_valid      
    end
    
    it "should be invalid if out of longitude bounds ( > 180 )" do
      point = "SRID=4326;POINT(181 50)"
      @tweet.location = point
      @tweet.should_not be_valid      
    end
    
    it "should be invalid if out of latitude bounds ( < -90 )" do
      point = "SRID=4326;POINT(50 -91)"
      @tweet.location = point
      @tweet.should_not be_valid      
    end
    
    it "should be invalid if out of latitude bounds ( > 90 )" do
      point = "SRID=4326;POINT(50 91)"
      @tweet.location = point
      @tweet.should_not be_valid      
    end
  end
  
  context "round_to_2_minutes" do
    it "should round to 2 minutes" do
      expect(@tweet.interval.to_i % 120).to eq(0)
    end
  end
end