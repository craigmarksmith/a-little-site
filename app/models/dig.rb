class Dig < ActiveRecord::Base
  has_and_belongs_to_many :dig_types
  
  validates_presence_of :name
end