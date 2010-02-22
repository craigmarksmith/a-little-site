class Theatre < ActiveRecord::Base
  has_many :theatre_distances
  has_many :digs, :through => :theatre_distances
end