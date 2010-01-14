class AddTour < ActiveRecord::Migration
  def self.up
    create_table :tours, :force => true do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :tours
  end
end
