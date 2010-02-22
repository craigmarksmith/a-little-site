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

  def setup
    @theatre_1 = Factory(:theatre, :name => "The old vic")
  end

  context "when a theatre hasn't been chosen" do
    should "ask them to choose one"
  end

  context "when there are search results" do
    setup do
      @dig = Factory(:dig, :name => "Dave's mega place", :number_of_double_rooms => 2)
      @dig.dig_types << Factory(:dig_type)
      @dig.save!

      Factory(:theatre_distance, :dig => @dig, :theatre => @theatre_1, :distance => 0.4 )

      get :search, basic_search_params(:theatre_id => @theatre_1.id)
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
      assert_select "ul li#dig-#{@dig.id}" do
        assert_select ".distance", "0.4"
      end
    end
  end

  context "when there are no products to display" do
    should "give appropriate message" do
      get :search, basic_search_params(:theatre_id => @theatre_1.id)
      assert_select "#content", "Sorry, no digs matched your search criteria"
    end
  end

end