require 'test_helper'

class DigsControllerTest < ActionController::TestCase

  def setup
    @tour = Factory(:tour, :name => 'Test Tour')
    @tour.update_attribute(:code,'ABC123')

    @dig = Factory(:dig, :name => 'Daves place', :address_1 => '42 Your Mum street')
    @dig.dig_types << Factory(:dig_type, :name => 'Living with Landlord')
  end

  context "when the user hasn't entered a tour id" do
    setup do
      get :show, :id => @dig.id
    end
    should "not show an address" do
      assert_select '.address-info', :count => 0
    end
    should "show enter tour id form" do
      assert_select '.tour-form'
    end
  end

  context "when a tour code has been entered" do
    setup do
      session['tour_code'] = 'ABC123'
      get :show, :id => @dig.id
    end
    should "show the dig address" do
      assert_select '.address-info'
    end
  end
  
  context "when entered a tour code" do
    context "when the incorrect code is given" do
      setup do
        post :authorise, :dig_id => @dig.id, :tour_code => 'WRONG'
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
        put :authorise, :tour_code => 'ABC123', :dig_id => @dig.id
      end
      should "redirect to dig page" do
        assert_redirected_to dig_path(@dig)
      end
      should "mark session as authorised" do
        assert_equal session['tour_code'], 'ABC123'
      end
    end
  
  end
end