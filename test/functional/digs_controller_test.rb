require 'test_helper'

class DigsControllerTest < ActionController::TestCase

  def setup
    @tour = Factory(:tour, :name => 'Test Tour')
    @tour.update_attribute(:code,'ABC123')

    @dig = Factory(:dig, :name => 'Daves place', :address_1 => '42 Your Mum street')
    @dig.dig_types << Factory(:dig_type, :name => 'Living with Landlord')
  end

  context "when looking at a dig" do
    should "say we don't know the price when it's zero" do
      @dig.update_attribute(:price_per_week_from,0)
      get :show, :id => @dig.id
      assert_select ".price-per-week-from", 'unknown'
    end
  end

  context "when the user hasn't entered a tour id" do
    setup do
      get :show, :id => @dig.id
    end
    should "not show the dig name" do
      assert_select "h1#name", :text => @dig.name, :count => 0
    end
    should "not show an address" do
      assert_select '.address-info', :count => 0
    end
    should "show enter tour id form" do
      assert_select '.tour-form'
    end
  end

  context "when there's no tour id but privacy is set to anyone" do
    setup do
      @dig.update_attribute(:privacy, Dig::PRIVACY_ANYONE)
      get :show, :id => @dig.id
    end
    should "show the dig address" do
      assert_select '.address-info'
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

class DigOwnerTest < ActionController::TestCase
  
  tests DigsController
  context "when an unexpected hash_code is entered" do
    should "throw not found" do
      assert_raises ActiveRecord::RecordNotFound do
        get :edit, :id => 'ABC123'
      end
    end
  end
  
  context "when editing digs" do
    setup do
      @dig = Factory(:dig, :name => 'Daves Digs')
    end
    should "be able to see my information" do
      get :edit, :id => @dig.hash_code
      assert_select "#dig_name[value=?]", 'Daves Digs'
    end
  end
end