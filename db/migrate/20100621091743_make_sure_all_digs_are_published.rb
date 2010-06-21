class MakeSureAllDigsArePublished < ActiveRecord::Migration
  def self.up
    update('UPDATE digs SET published = TRUE;')
  end

  def self.down
  end
end
