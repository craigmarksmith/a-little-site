# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def main_menu_link(text, link, options = {})
    options.merge!({:class => 'selected'}) if (text == selected_menu_item)
    link_to text, link, options
  end
end
