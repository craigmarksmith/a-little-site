require 'user'
class CreateTempUser < ActiveRecord::Migration
  def self.up
    User.create!(:username => 'admin', :password => 'password', :password_confirmation => 'password')
  end

  def self.down
  end
end
