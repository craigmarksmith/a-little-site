# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  def selected_menu_item
    self.class.name.match(/Admin::(.+)Controller/)
    $1
  end 
  helper_method(:selected_menu_item)

  def admin_title
    self.class.name.match(/Admin::(.+)Controller/)
    return "Admin" if $1 == 'Home'
    "#{$1} Admin"
  end
  helper_method(:admin_title)
end
