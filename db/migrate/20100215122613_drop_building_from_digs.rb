class DropBuildingFromDigs < ActiveRecord::Migration
  def self.up
    remove_column :digs, :building
  end

  def self.down
    add_column :digs, :building, :string
  end
end
