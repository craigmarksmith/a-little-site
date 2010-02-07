class Admin::DigTypesController < AdminController
  layout 'admin'

  def index
    @dig_types = DigType.all
  end

  def new
    @dig_type = DigType.new
  end

  def create
    @dig_type = DigType.new(params[:dig_type])
    unless @dig_type.valid?
      render :action => "new"
      return
    end

    @dig_type.save!
    redirect_to :action => 'index'
  end

  def edit
    @dig_type = DigType.find(params[:id])
  end

  def update
    DigType.find(params[:id]).update_attributes(params[:dig_type])
    redirect_to :action => 'index'
  end

end
