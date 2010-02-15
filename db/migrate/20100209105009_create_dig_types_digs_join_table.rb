class CreateDigTypesDigsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :dig_types_digs, :id => false do |t|
      t.integer :dig_id
      t.integer :dig_type_id
    end
    
    remove_column :digs, :dig_type_id
  end

  def self.down
    add_column :digs, :dig_type_id, :integer
    drop_table :dig_types_digs
  end
end
