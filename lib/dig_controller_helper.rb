module DigControllerHelper
  def dig_params
    dig_params = params[:dig]
    price_per_week_from = (dig_params['price_per_week_from_pounds'].to_i*100) + dig_params['price_per_week_from_pence'].to_i
    dig_params.merge!('price_per_week_from' => price_per_week_from)
    dig_params.reject!{|k,v| ['price_per_week_from_pence', 'price_per_week_from_pounds'].include?(k)}
  end
end