require 'test_helper'

class DigsControllerTest < ActionController::TestCase

  def setup
    @dig = Factory(:dig, :name => 'Daves place')
    @dig.dig_types << Factory(:dig_type, :name => 'Living with Landlord')
  end

  context "when the user hasn't entered a tour id" do
    setup do
      get :show, :id => @dig.id
    end
    should "redirect to id entry page" do
      assert_redirected_to :controller => 'tour', :action => 'enter_code', :dig_id => @dig.id
    end
  end
  
  context "when a tour code has been entered" do
    setup do
      session['tour_code'] = 'ABC123'
      get :show, :id => @dig.id
    end
    should "show the dig name" do
      assert_select "#name", "Daves place"
    end
  end
end