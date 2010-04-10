class DigsController < ApplicationController
  
  before_filter :authorise
  
  def show
    @dig = Dig.find(params[:id])
  end
  
private
  def authorise
    return if session['tour_code']
    redirect_to tour_code_entry_url(:dig_id => params[:id])
  end
  
end