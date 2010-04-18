class SearchController < ApplicationController
  def new
    @search = Search.new
  end

  def search
    @search = Search.new(params['search'])

    session['last-search'] = params['search']

    unless @search.valid?
      render :action => 'new'
      return
    end

    @theatre = Theatre.find(params['search']['theatre_id'])
  end

end