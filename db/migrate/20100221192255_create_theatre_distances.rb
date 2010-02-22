class CreateTheatreDistances < ActiveRecord::Migration
  def self.up
    create_table :theatre_distances, :force => true do |t|
      t.integer :dig_id
      t.integer :theatre_id
      t.float :distance
      t.timestamps
    end
  end

  def self.down
    drop_table :theatre_distances
  end
end
