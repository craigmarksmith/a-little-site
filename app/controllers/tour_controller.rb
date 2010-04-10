class TourController < ApplicationController

  def enter_code
  end

  def authorise
    tour = Tour.find_by_code(params[:tour_code])

    unless tour
      @error = 'Code not recognised'
      render :action => 'enter_code'
      return
    end

    session['tour_code'] = params[:tour_code]
    redirect_to dig_path(params[:dig_id])
  end

end