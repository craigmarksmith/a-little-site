require 'test_helper'

class TourTest < ActiveSupport::TestCase
  def test_should_generate_code
    tour = Tour.create!(:name => "Mega Tour" )
    assert tour.reload.code
  end
end