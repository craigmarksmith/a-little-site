require 'test_helper'

class DigTest < ActiveSupport::TestCase
  def test_should_generate_a_hash_code
    dig = Dig.create!(:name => "Daves lovely old place" )
    assert dig.reload.hash_code
  end
end