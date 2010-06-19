class DigsController < ApplicationController
  layout 'one_column'

  include DigControllerHelper

  def show
    @dig = Dig.find(params[:id])
  end

  def edit
    @dig = Dig.find_by_hash_code!(params[:id])
  end

  def update
    @dig = Dig.find_by_hash_code!(params[:id])
    @dig.update_attributes(dig_params)

    render :template => '/digs/successful_update.html.erb'
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

  helper_method :is_authorised?, :in_admin_area?

private
  def is_authorised?
    session['tour_code'] || @dig.privacy == Dig::PRIVACY_ANYONE
  end

end