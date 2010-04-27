require 'dig'
class AddHashToDig < ActiveRecord::Migration
  def self.up
    add_column :digs, :hash_code, :string

    Dig.all.each do |dig|
      dig.create_hash_code
      dig.save!
    end

    add_index :digs, :hash_code
  end

  def self.down
    remove_index :digs, :hash_code
    remove_column :digs, :hash_code
  end
end
