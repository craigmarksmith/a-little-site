class SearchController < ApplicationController
  def new
    @search = Search.new
  end
  
  def search
    @search = Search.new(params)
  end

end