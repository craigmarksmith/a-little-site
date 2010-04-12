class CantHaveANullPrice < ActiveRecord::Migration
  def self.up
    change_column :digs, :price_per_week_from, :integer, :default => 0, :null => false
  end

  def self.down
    change_column :digs, :price_per_week_from, :integer
  end
end
