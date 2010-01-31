class Admin::ToursController < AdminController
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

  def edit
    @tour = Tour.find(params[:id])
  end

  def update
    Tour.find(params[:id]).update_attributes(params[:tour])
    redirect_to :action => 'index'
  end

end
