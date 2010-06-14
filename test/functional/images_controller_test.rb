require 'test_helper'

class ImagesControllerTest < ActionController::TestCase

  def setup
    @dig = Factory(:dig)
  end

  context "when you're not a member" do
    setup do
      2.times do
        @dig.images << Factory(:image)
      end
    end
    should "allow only 2 images" do
      get :index, :dig_id => @dig.hash_code
      assert_select "#images_photo", :count => 0
    end
  end

  context "when you're a member" do
    setup do
      @dig.update_attribute(:member, true)
      2.times do
        @dig.images << Factory(:image)
      end
    end
    should "allow over 2 images" do
      get :index, :dig_id => @dig.hash_code
      assert_select "#images_photo", :count => 1
    end
    should "allow a maximum of ten images" do
      8.times do
        @dig.images << Factory(:image)
      end
      get :index, :dig_id => @dig.hash_code
      assert_select "#images_photo", :count => 0
    end
  end

end