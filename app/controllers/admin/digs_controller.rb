class Admin::DigsController < AdminController
  layout 'admin'

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

  def update
    Dig.find(params[:id]).update_attributes(params[:dig])
    redirect_to :action => 'index'
  end

  def upload_dig_sheet
    file = params[:upload]['datafile']
    HotelsImporter.import(file.path)
    redirect_to :action => 'index'
  end

end
