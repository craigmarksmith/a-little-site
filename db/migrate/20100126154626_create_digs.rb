class CreateDigs < ActiveRecord::Migration
  def self.up
    create_table :digs, :force => true do |t|
      t.string :name
      t.string :type
      t.string :building
      t.integer :sleeps
      t.integer :number_of_twin_rooms
      t.integer :number_of_double_rooms
      t.integer :number_of_single_rooms
      t.integer :number_of_sofa_beds
      t.text :landlords_notes
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :postcode
      t.string :landline
      t.string :mobile
      t.string :fax
      t.text :remarks
      t.timestamps
    end
  end

  def self.down
    drop_table :digs
  end
end
