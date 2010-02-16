class CreateDigTypes < ActiveRecord::Migration
  def self.up
    create_table :dig_types, :force => true do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :dig_types_digs, :id => false do |t|
      t.integer :dig_id
      t.integer :dig_type_id
    end
  end

  def self.down
    drop_table :dig_types_digs
    drop_table :dig_types
  end
end
