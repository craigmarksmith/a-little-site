require 'digest/md5'
class Dig < ActiveRecord::Base
  has_and_belongs_to_many :dig_types
  has_many :theatre_distances
  has_many :theatres, :through => :theatre_distances
  validates_presence_of :name

  after_create :create_hash_code

  def create_hash_code
    self[:hash_code] = Digest::SHA1.hexdigest(Time.now.to_s + "PHIL-THINKS-THAT-YOU-SHOULD-PROBABLY-PAY-FOR-A-DRINK" + name)
    save!
  end
end