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
      as_logged_in_user do
        get :edit, :id => @dig.id
      end
    end
    should "be able to edit theatre distances" do
      assert_select "#dig_theatre_distances_attributes_0_distance", :count => 1
    end
  end

  context "When updating a dig path" do
    should "update it" do
      old_path = @dig.hash_code
      sleep 1
      as_logged_in_user do
        post :regenerate_dig_path, :id => @dig.id
      end
      assert old_path != @dig.reload.hash_code
    end
  end

  def as_logged_in_user
    user = User.create!(:username => 'test', :password => 'abc123', :password_confirmation => 'abc123')
    UserSession.create(user)
    yield
  end
end
