require 'dig'
class AddPrivacySettingsToDigs < ActiveRecord::Migration
  def self.up
    add_column :digs, :privacy, :string, :default => Dig::PRIVACY_THEATRE_PROFESSIONALS_ONLY
  end

  def self.down
    remove_column :digs, :privacy
  end
end
