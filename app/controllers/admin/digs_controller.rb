class Admin::DigsController < AdminController
  layout 'admin'

  include DigControllerHelper

  def index
    @digs = Dig.all
  end

  def new
    @dig = Dig.new
  end

  def create
    @dig = Dig.new(dig_params)
    unless @dig.valid?
      render :action => "new"
      return
    end

    Theatre.all.each do |theatre|
      @dig.theatre_distances << TheatreDistance.create!(:theatre => theatre, :dig => @dig, :distance => 0)
    end

    @dig.save!
    redirect_to :action => 'index'
  end

  def edit
    @dig = Dig.find(params[:id])
  end

  def destroy
    Dig.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  def update
    @dig = Dig.find(params[:id])
    @dig.update_attributes(dig_params)
    unless @dig.valid?
      render :action => "new"
      return
    end
    redirect_to :action => 'index'
  end

  def toggle_published
    @dig = Dig.find(params[:id])

    if @dig.published?
      @dig.update_attribute(:published, false)
    else
      @dig.update_attribute(:published, true)
    end

    redirect_to :action => 'index'
  end

  def upload_dig_sheet
    file = params[:upload]['datafile']
    HotelsImporter.import(file.path)
    redirect_to :action => 'index'
  end

  def regenerate_dig_path
    @dig = Dig.find(params[:id])
    @dig.create_hash_code
    redirect_to :action => 'index'
  end

  helper_method :in_admin_area?
end
