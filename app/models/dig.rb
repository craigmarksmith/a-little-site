class Dig < ActiveRecord::Base
  belongs_to :dig_type
  
  validates_presence_of :name, :dig_type_id
end