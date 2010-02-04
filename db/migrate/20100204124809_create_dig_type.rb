class CreateDigType < ActiveRecord::Migration
  def self.up
    create_table :dig_types, :force => true do |t|
      t.string :name
      t.timestamps
    end
    
    add_column :digs, :dig_type_id, :int
    remove_column :digs, :type
  end

  def self.down
    add_column :digs, :type, :string
    remove_column :digs, :dig_type_id
    drop_table :dig_types
  end
end
