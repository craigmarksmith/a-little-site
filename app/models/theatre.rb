class Theatre < ActiveRecord::Base
  has_many :theatre_distances
  has_many :digs, :through => :theatre_distances

  validates_uniqueness_of :name
end