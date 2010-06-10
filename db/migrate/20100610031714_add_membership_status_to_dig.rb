class AddMembershipStatusToDig < ActiveRecord::Migration
  def self.up
    add_column :digs, :member, :boolean, :default => false
  end

  def self.down
    remove_column :digs, :member
  end
end
