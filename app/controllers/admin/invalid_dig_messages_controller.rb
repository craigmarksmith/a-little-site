class Admin::InvalidDigMessagesController < AdminController
  def index
    @messages = InvalidDigMessage.all(:order => 'created_at')
  end

  def show
    @message = InvalidDigMessage.find(params[:id])
  end
end
