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
    teardown do
      ActionMailer::Base.deliveries.clear
    end
    should "send an email to phil" do
      assert_equal 1, ActionMailer::Base.deliveries.length
    end
    should "redirect back to dig page with thanks message" do
      assert_equal flash[:notice], "Thanks, your message has been sent."
      assert_redirected_to(dig_path(123))
    end
    context "the email" do
      setup do
        @email = ActionMailer::Base.deliveries.first
      end
      should "include the users message" do
        assert @email.body.match(/A test message/)
      end
      should "include the dig path" do
        assert @email.body.match(/#{dig_url(123)}/)
      end
      should "have a subject" do
        assert_equal "Possible invalid dig, ID: 123", @email.subject
      end
      should "be from the site" do
        assert @email.from.include?("DONOTREPLY@theatredigsbooker.com")
      end
      should "send it to phil" do
        assert @email.to.include?("admin@theatredigsbooker.com")
      end
    end
  end
  
  context "When your message is empty" do
    setup do
      post :create, :message => ''
    end
    should "tell you what's wrong" do
      assert_select ".error", "Sorry, could you please be a little more specific about your issue with this dig. Your message can't be blank."
    end
  end

end