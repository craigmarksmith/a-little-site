class AddColumnsToDigs < ActiveRecord::Migration
  def self.up
    add_column :digs, :price_per_night, :integer
    add_column :digs, :building, :string
    add_column :digs, :price_per_week, :string
  end

  def self.down
    remove_column :digs, :price_per_week
    remove_column :digs, :building
    remove_column :digs, :price_per_night
  end
end
