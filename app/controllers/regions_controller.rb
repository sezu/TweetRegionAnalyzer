class RegionsController < ApplicationController
  def create
    Region.generate_region(
      params[:name], 
      [params[:sw_long], params[:sw_long]],
      [params[:ne_long], params[:ne_long]]      
    )
    
    @regions = Region.all
    render "index"
  end
  
  def index
    @regions = Region.all
  end
  
  def show
    @region = Region.find(params[:id])
  end
end
