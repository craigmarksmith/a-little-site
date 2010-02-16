class Search

  ATTRIBUTES = [:theatre_id, :dig_type_id, :number_of_sofa_beds, :number_of_single_rooms, :number_of_twin_rooms, :number_of_double_rooms]
  attr_accessor *ATTRIBUTES

  def initialize(params = {})
    params.each do |key, value|
      method = "#{key}=".to_sym
      send(method, value) if respond_to? method
    end
  end

  def results
    dig_conditions = []
    dig_conditions << "dig_types.id = :dig_type_id" if !dig_type_id.empty?
    dig_conditions << "number_of_sofa_beds >= :number_of_sofa_beds" if number_of_sofa_beds
    dig_conditions << "number_of_single_rooms >= :number_of_single_rooms" if number_of_single_rooms
    dig_conditions << "number_of_twin_rooms >= :number_of_twin_rooms" if number_of_twin_rooms
    dig_conditions << "number_of_double_rooms >= :number_of_double_rooms" if number_of_double_rooms

    Dig.find(:all, :joins => [:dig_types], :conditions => [dig_conditions.join(' AND '),  attributes])
  end

  def attributes
    ATTRIBUTES.inject({}) do |acc, attribute|
      acc.merge(attribute => self.send(attribute))
    end
  end
end