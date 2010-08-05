class InvalidDigsController < ApplicationController
  layout 'one_column'

  def new
    @message = InvalidDigMessage.new(:dig_id => params[:dig_id])
  end

  def create
    @message = InvalidDigMessage.new(params['message'])
    unless @message.valid?
      render :action => 'new'
      return
    end
    @message.save!
    flash[:notice] = "Thanks, your message has been sent."
    redirect_to dig_path(@message.dig_id)
  end
end
