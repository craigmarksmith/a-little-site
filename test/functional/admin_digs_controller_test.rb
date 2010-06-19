require 'test_helper'

class Admin::DigsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  def setup
    theatre = Factory(:theatre)
    @dig = Factory(:dig)
    Factory(:theatre_distance, :dig => @dig, :theatre => theatre, :distance => 1.2)
  end

  context "When editing a dig" do
    setup do
      user = User.create!(:username => 'test', :password => 'abc123', :password_confirmation => 'abc123')
      UserSession.create(user)
      get :edit, :id => @dig.id
    end
    should "be able to edit theatre distances" do
      assert_select "#dig_theatre_distances_attributes_0_distance", :count => 1
    end
  end
end