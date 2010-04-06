class AddPricePerWeekFromToDigs < ActiveRecord::Migration
  def self.up
    add_column :digs, :price_per_week_from, :integer
  end

  def self.down
    remove_column :digs, :price_per_week_from
  end
end
