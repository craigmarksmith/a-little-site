class AddCodeToTour < ActiveRecord::Migration
  def self.up
    add_column :tours, :code, :string
  end

  def self.down
    remove_column :tours, :code
  end
end
