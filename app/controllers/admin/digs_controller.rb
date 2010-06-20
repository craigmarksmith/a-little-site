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
    @dig = Dig.new(params[:dig])
    unless @dig.valid?
      render :action => "new"
      return
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
