class Admin::UsersController < AdminController
  layout 'admin'

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    User.create!(params[:user])
    redirect_to :action => 'index'
  end
  
  def edit
    @dig = User.find(params[:id])
  end
  
  def update
    User.find(params[:id]).update_attributes(params[:user])
    redirect_to :action => 'index'
  end

end
