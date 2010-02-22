class SearchController < ApplicationController
  def new
    @search = Search.new
  end
  
  def search
    @theatre = Theatre.find(params[:theatre_id])
    @search = Search.new(params)
  end

end