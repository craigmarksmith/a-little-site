class AddPublishedToDigs < ActiveRecord::Migration
  def self.up
    add_column :digs, :published, :boolean, :default => true
  end

  def self.down
    remove_column :digs, :published
  end
end
