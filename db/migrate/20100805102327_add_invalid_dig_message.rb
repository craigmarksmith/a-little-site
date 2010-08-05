class AddInvalidDigMessage < ActiveRecord::Migration
  def self.up
    create_table :invalid_dig_messages, :force => true do |t|
      t.belongs_to :dig
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :invalid_dig_messages
  end
end
