class MakeSearchFaster < ActiveRecord::Migration
  def self.up
    add_index :theatre_distances, :dig_id
    add_index :dig_types_digs, :dig_type_id
  end

  def self.down
    remove_index :dig_types_digs, :dig_type_id
    remove_index :theatre_distances, :dig_id
  end
end
