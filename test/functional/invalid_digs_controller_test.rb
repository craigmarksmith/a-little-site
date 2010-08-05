require 'test_helper'

class InvalidDigsControllerTest < ActionController::TestCase

  context "When on the invalid digs page" do
    setup do
      get :new
    end
    should "be able to say what's wrong with the dig" do
      assert_select "form.whats-the-problem textarea.message"
    end
  end

  context "When reporting an invalid dig" do
    setup do
      post :create, :message => {:message => 'A test message', :dig_id => 123}
    end

    should "store the message" do
      assert_equal 1, InvalidDigMessage.count
      assert_equal 123, InvalidDigMessage.first.dig_id
      assert_equal 'A test message', InvalidDigMessage.first.message
    end
    should "redirect back to dig page with thanks message" do
      assert_equal flash[:notice], "Thanks, your message has been sent."
      assert_redirected_to(dig_path(123))
    end
  end

  context "When your message is empty" do
    setup do
      post :create, :message => {:message => '', :dig_id => 12}
    end
    should "tell you what's wrong" do
      assert_select ".error", "Sorry, could you please be a little more specific about your issue with this dig. Your message can't be blank."
    end
  end

end
