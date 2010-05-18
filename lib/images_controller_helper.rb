module ImagesControllerHelper
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

  def delete
    image = Image.find(params[:id])
    dig = image.dig
    image.destroy
    redirect_to :action => 'index', :dig_id => dig.hash_code
  end
end