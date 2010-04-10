require 'test_helper'

class TourControllerTest < ActionController::TestCase

  def setup
    @tour = Factory(:tour, :name => 'Test Tour')
    @tour.update_attribute(:code,'ABC124')
    @dig = Factory(:dig)
  end

  context "when the incorrect code is given" do
    setup do
      post :authorise, :tour_code => 'WRONG'
    end
    should "show error message" do
      assert_select ".error", 'Code not recognised'
    end
    should "not authorise" do
      assert_nil session['tour_code']
    end
  end

  context "when the correct code is given" do
    setup do
      put :authorise, :tour_code => 'ABC124', :dig_id => @dig.id
    end
    should "redirect to dig page" do
      assert_redirected_to dig_path(@dig)
    end
    should "mark session as authorised" do
      assert_equal session['tour_code'], 'ABC124'
    end
  end
end