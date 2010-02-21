require 'test_helper'

class SearchControllerTest < ActionController::TestCase

  def basic_search_params(params = {})
    {
      :number_of_sofa_beds => '0',
      :number_of_single_rooms => '0',
      :number_of_twin_rooms => '0',
      :number_of_double_rooms => '0'
    }.merge(params)
  end

  context "when there are search results" do
    setup do
      @dig = Factory(:dig, :name => "Dave's mega place", :number_of_double_rooms => 2)
      @dig.dig_types << Factory(:dig_type)
      @dig.save!
      get :search, basic_search_params
    end

    should "show each name" do
      assert_select "ul li#dig-#{@dig.id} .name", "Dave's mega place"
    end

    should "show number of beds" do
      assert_select "ul li#dig-#{@dig.id}" do
        assert_select ".number_of_sofa_beds", '0'
        assert_select ".number_of_single_rooms", '0'
        assert_select ".number_of_twin_rooms", '0'
        assert_select ".number_of_double_rooms", '2'
      end
    end
  
    should "show distance to chosen theatre" do
      flunk
    end
  end
  
  context "when there are no products to display" do
    should "give appropriate message" do
      get :search, basic_search_params
      assert_select "#content", "Sorry, no digs matched your search criteria"
    end
  end

end