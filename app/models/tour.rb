require 'digest/md5'

class Tour < ActiveRecord::Base
  after_create :create_code

private
  def create_code
    self[:code] = Digest::SHA1.hexdigest(Time.now.to_s + "PHIL-SMELLS-OF-POO" + name)
    save!
  end
end