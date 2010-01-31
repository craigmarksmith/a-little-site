class AdminController < ApplicationController
  before_filter :authenticate
  def authenticate
    redirect_to login_url unless UserSession.find
  end
end
