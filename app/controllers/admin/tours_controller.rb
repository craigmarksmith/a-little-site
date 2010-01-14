class Admin::ToursController < ApplicationController
  layout 'admin'

  def index
    @tours = Tour.all
  end

  def new
    @tour = Tour.new
  end
  
  def create
    Tour.create!(params[:tour])
    redirect_to :action => 'index'
  end

end
