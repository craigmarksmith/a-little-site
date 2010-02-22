class Dig < ActiveRecord::Base
  has_and_belongs_to_many :dig_types
  has_many :theatre_distances
  has_many :theatres, :through => :theatre_distances
  validates_presence_of :name
end