require 'test_helper'

class TheatreTest < ActiveSupport::TestCase
  def setup
    Factory(:theatre)
  end
  should_validate_uniqueness_of :name
end