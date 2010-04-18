require 'test_helper'

class SearchControllerTest < ActionController::TestCase

  def basic_search_params(params = {})
    {'search' => {
      'number_of_sofa_beds' => '0',
      'number_of_single_rooms' => '0',
      'number_of_twin_rooms' => '0',
      'number_of_double_rooms' => '0'
    }.merge(params)}
  end

  def setup
    Factory(:dig, :price_per_week_from => 3000)
    Factory(:dig, :price_per_week_from => 4000)
    Factory(:dig, :price_per_week_from => 5000)
    @theatre_1 = Factory(:theatre, :name => "The old vic")
  end

  context "when a theatre hasn't been chosen" do
    setup do
      get :search, basic_search_params('theatre_id' => nil)
    end

    should "ask them to choose one" do
      assert_select "#sidebar .error", :text => 'Please select a theatre'
    end

    should "show no search result" do
      assert_select "#content ul li", :count => 0
    end
  end

  context "when there are search results" do
    setup do
      @dig_1 = Factory(:dig, :name => "Dave's mega place", :number_of_double_rooms => 2, :price_per_week_from => 1200, :sleeps => 4)
      @dig_2 = Factory(:dig, :name => "No places", :number_of_double_rooms => 2, :price_per_week_from => 900)
      @dig_3 = Factory(:dig, :name => "Pretty far", :number_of_double_rooms => 2, :price_per_week_from => 1000)

      dig_type = Factory(:dig_type, :name => 'Living with Landlord')

      @dig_1.dig_types << dig_type
      @dig_2.dig_types << dig_type
      @dig_3.dig_types << dig_type

      Factory(:theatre_distance, :dig => @dig_1, :theatre => @theatre_1, :distance => 1.4 )
      Factory(:theatre_distance, :dig => @dig_3, :theatre => @theatre_1, :distance => 0.3 )

      get :search, basic_search_params('theatre_id' => @theatre_1.id.to_s)
    end

    should "save the search to the session so we can go back" do
      assert_equal @theatre_1.id.to_s, @request.session['last-search']['theatre_id']
    end

    should "show number of beds" do
      assert_select "ul li#dig-#{@dig_1.id}" do
        assert_select ".number_of_sofa_beds", '0'
        assert_select ".number_of_single_rooms", '0'
        assert_select ".number_of_twin_rooms", '0'
        assert_select ".number_of_double_rooms", '2'
      end
    end

    should "show the price per week" do
      assert_select "ul li#dig-#{@dig_1.id}" do
        assert_select ".price-per-week", '£12'
      end
    end

    should "show distance to chosen theatre" do
      assert_select "ul li#dig-#{@dig_1.id}" do
        assert_select ".distance", "1.4"
      end
    end

    should "order by distance" do
      assert_select "ul li#dig-#{@dig_1.id}:nth-child(2)"
      assert_select "ul li#dig-#{@dig_3.id}:nth-child(1)"
    end

    should "not show digs that are not related to the chosen theatres" do
      assert_select "ul li#dig-#{@dig_2.id}", :count => 0
    end
  end

  context "when there are no products to display" do
    should "give appropriate message" do
      get :search, basic_search_params('theatre_id' => @theatre_1.id.to_s)
      assert_select "#content", "Sorry, no digs matched your search criteria"
    end
  end

end