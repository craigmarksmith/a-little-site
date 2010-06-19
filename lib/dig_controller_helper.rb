module DigControllerHelper
  def dig_params
    dig_params = params[:dig]
    price_per_week_from = (dig_params['price_per_week_from_pounds'].to_i*100) + dig_params['price_per_week_from_pence'].to_i
    dig_params.merge!('price_per_week_from' => price_per_week_from)
    dig_params.reject!{|k,v| ['price_per_week_from_pence', 'price_per_week_from_pounds'].include?(k)}

    dig_params.delete('member') unless in_admin_area?

    dig_params
  end

  def in_admin_area?
    self.class.to_s =~ /Admin/
  end
end