class Admin::ImagesController < AdminController
  layout 'admin'

  def index
    @dig = Dig.find_by_hash_code(params[:dig_id])
  end

  def create
    @dig = Dig.find_by_hash_code(params[:dig_id])
    image = Image.create!(params[:images])

    @dig.images << image
    @dig.save!

    redirect_to :action => 'index'
  end
end
