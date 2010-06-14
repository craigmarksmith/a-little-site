class TheatreDistance < ActiveRecord::Base
  belongs_to :dig
  belongs_to :theatre
  delegate :name, :to => :theatre
end