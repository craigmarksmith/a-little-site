class Search

  ATTRIBUTES = ['theatre_id', 'dig_type_id', 'number_of_sofa_beds', 'number_of_single_rooms', 'number_of_twin_rooms', 'number_of_double_rooms', 'price_range_from', 'price_range_to', 'hide_digs_without_prices', 'sort_by']
  attr_accessor *ATTRIBUTES

  SORT_ORDERS = [
    ['Price (lowest first)','price_per_week_from asc'],
    ['Price (highest first)', 'price_per_week_from desc'],
    ['Distance (closest first)', 'theatre_distances.distance ASC']
  ]

  def initialize(params = {})
    @errors = {}
    params.each do |key, value|
      method = "#{key}="
      send(method, value) if respond_to?(method) && value && !value.empty?
    end
  end

  def results
    return [] unless valid?
    dig_conditions = []
    dig_conditions << "published = true"
    dig_conditions << "dig_types.id = :dig_type_id" if dig_type_id && !dig_type_id.empty?
    dig_conditions << "theatres.id = :theatre_id" if theatre_id && !theatre_id.empty?
    dig_conditions << "number_of_sofa_beds >= :number_of_sofa_beds" if number_of_sofa_beds
    dig_conditions << "number_of_single_rooms >= :number_of_single_rooms" if number_of_single_rooms
    dig_conditions << "number_of_twin_rooms >= :number_of_twin_rooms" if number_of_twin_rooms
    dig_conditions << "number_of_double_rooms >= :number_of_double_rooms" if number_of_double_rooms
    dig_conditions << "price_per_week_from >= :price_range_from" if price_range_from
    dig_conditions << "price_per_week_from <= :price_range_to" if price_range_to
    dig_conditions << "price_per_week_from > 0" if hide_digs_without_prices

    Dig.find(
      :all,
      :joins => [:dig_types, :theatres],
      :conditions => [dig_conditions.join(' AND '),  attributes],
      :order => sort_order
    )
  end

  def attributes
    ATTRIBUTES.inject({}) do |acc, attribute|
      acc.merge(attribute.to_sym => self.send(attribute))
    end
  end

  def valid?
    @errors['theatre_id'] = 'Please select a theatre' unless theatre_id && !theatre_id.empty?
    return @errors.empty?
  end

  def errors_for(attribute)
    @errors[attribute]
  end

  def theatre
    Theatre.find(theatre_id)
  end
  
  def sort_order
    return sort_by || 'theatre_distances.distance ASC'
  end
end