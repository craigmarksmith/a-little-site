class Admin::DigsController < ApplicationController
  layout 'admin'

  def index
    @digs = Dig.all
  end

  def new
    @dig = Dig.new
  end

  def create
    Dig.create!(params[:dig])
    redirect_to :action => 'index'
  end

  def edit
    @dig = Dig.find(params[:id])
  end

  def update
    Dig.find(params[:id]).update_attributes(params[:dig])
    redirect_to :action => 'index'
  end

end
