class Admin::ToursController < AdminController
  layout 'admin'

  def index
    @tours = Tour.all
  end

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new(params[:tour])
    unless @tour.valid?
      render :action => "new"
      return
    end
    
    @tour.save!
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
