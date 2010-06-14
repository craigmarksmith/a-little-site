require 'digest/md5'
class Dig < ActiveRecord::Base

  PRIVACY_THEATRE_PROFESSIONALS_ONLY = 'theatre professionals only'
  PRIVACY_ANYONE = 'anyone'

  PRIVACY_OPTIONS = [PRIVACY_THEATRE_PROFESSIONALS_ONLY, PRIVACY_ANYONE]

  has_and_belongs_to_many :dig_types
  has_many :theatre_distances
  accepts_nested_attributes_for :theatre_distances
  has_many :theatres, :through => :theatre_distances
  has_many :images
  validates_presence_of :name
  validates_length_of :landlords_notes, :maximum => 140, :allow_nil => true, :allow_blank => true, :if => lambda {|dig| !dig.member?}

  after_create :create_hash_code

  def create_hash_code
    self[:hash_code] = Digest::SHA1.hexdigest(Time.now.to_s + "PHIL-THINKS-THAT-YOU-SHOULD-PROBABLY-PAY-FOR-A-DRINK" + name)
    save!
  end

  def price_per_week_from_pounds
   price_per_week_from/100.to_i
  end

  def price_per_week_from_pence
    price_per_week_from.to_s[-2,2]
  end
end