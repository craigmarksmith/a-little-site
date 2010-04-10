class RemoveRemarksFromDig < ActiveRecord::Migration
  def self.up
    remove_column :digs, :remarks
  end

  def self.down
    add_column :digs, :remarks, :text
  end
end
