# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def main_menu_link(text, link, options = {})
    options.merge!({:class => 'selected'}) if (text == selected_menu_item)
    link_to text, link, options
  end

  def price_per_week_from(dig)
    currency_hash = {:unit => '£', :precision => 0}
    currency_hash[:precision] = 2 unless dig.price_per_week_from_pence == '00'

    number_to_currency(dig.price_per_week_from.to_f/100, currency_hash)
  end

  def address_line(data, label = nil)
    label = "#{label}: " if label
    "<span class='address-label'>#{label}</span><span class='address-info'>#{data}</span><br/>" if data
  end

  def javascript_feature_classes
    (@javascript_features || []).map{|feature| "with-js-#{feature}"}.join(" ")
  end

  def use_javascript_for(feature)
    @javascript_features ||= []
    @javascript_features << feature
  end
end
