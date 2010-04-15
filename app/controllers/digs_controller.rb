class DigsController < ApplicationController
  layout 'one_column'

  def show
    @dig = Dig.find(params[:id])
  end

  def authorise
    @dig = Dig.find(params[:dig_id])
    tour = Tour.find_by_code(params[:tour_code])

    unless tour
      @error = 'Code not recognised'
      render :action => 'show'
      return
    end

    session['tour_code'] = params[:tour_code]
    redirect_to dig_path(params[:dig_id])
  end

  helper_method :is_authorised?

private
  def is_authorised?
    session['tour_code']
  end

end