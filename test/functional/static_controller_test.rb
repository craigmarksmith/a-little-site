require 'test_helper'

class StaticControllerTest < ActionController::TestCase

  def test_should_show_the_faq
    get :faq
    assert_select "h1", 'Frequently Asked Questions'
  end

end