class InvalidDigMessage < ActiveRecord::Base
  validates_presence_of :message, :dig_id
  belongs_to :dig
end
