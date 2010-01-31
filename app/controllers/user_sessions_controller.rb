class UserSessionsController < ActionController::Base
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to admin_homepage_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    UserSession.find.destroy
    redirect_to login_url
  end
end