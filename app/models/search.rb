class Search
  attr_accessor :theatre_id, :dig_type_id, :number_of_sofa_beds, :number_of_single_rooms, :number_of_twin_rooms, :number_of_double_rooms

  def initialize(params = {})
    params.each do |key, value|
      method = "#{key}=".to_sym
      send(method, value) if respond_to? method
    end
  end
end