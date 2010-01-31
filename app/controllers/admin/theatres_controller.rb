class Admin::TheatresController < AdminController
  layout 'admin'

  def index
    @theatres = Theatre.all
  end

  def new
    @theatre = Theatre.new
  end

  def create
    Theatre.create!(params[:theatre])
    redirect_to :action => 'index'
  end

  def edit
    @theatre = Theatre.find(params[:id])
  end

  def update
    Theatre.find(params[:id]).update_attributes(params[:theatre])
    redirect_to :action => 'index'
  end

end
