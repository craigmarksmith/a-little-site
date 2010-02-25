class SearchController < ApplicationController
  def new
    @search = Search.new
  end

  def search
    @search = Search.new(params)

    unless @search.valid?
      render :action => 'new'
      return
    end
  end

end