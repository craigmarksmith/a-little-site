class InvalidDigsController < ApplicationController
  layout 'one_column'

  def new
    @message = Message.new(:dig_id => params[:dig_id])
  end

  def create
    @message = Message.new(params['message'])
    unless @message.valid?
      render :action => 'new'
      return
    end

    EmailNotifications.deliver_invalid_dig_email(@message)
    flash[:notice] = "Thanks, your message has been sent."
    redirect_to dig_path(@message.dig_id)
  end
end

class Message < ActiveForm
  attr_accessor :message
  attr_accessor :dig_id

  validates_presence_of :message
end
