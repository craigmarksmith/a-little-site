class CreateTheatre < ActiveRecord::Migration
  def self.up
    create_table :theatres, :force => true do |t|
      t.string :name
      t.string :postcode
      t.timestamps
    end
  end

  def self.down
    drop_table :theatres
  end
end
