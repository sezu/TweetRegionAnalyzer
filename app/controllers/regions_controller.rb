class RegionsController < ApplicationController
  def create
    Region.generate_region(
      params[:name], 
      [params[:sw_long], params[:sw_lat]],
      [params[:ne_long], params[:ne_lat]]      
    )
    
    @regions = Region.all
    render "index"
  end
  
  def index
    @regions = Region.all
  end
  
  def show
    @region = Region.find(params[:id])
    @tweet_counts = @region.intervals_with_tweet_counts
  end
end
