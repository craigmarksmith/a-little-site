require 'factory_girl'

Factory.sequence :dig_name do |n|
  "Dig #{n}"
end

Factory.define :dig do |d|
  d.name{ Factory.next :dig_name }
  # d.association :dig_type
end

Factory.define :dig_type do |dt|
  dt.name "Dig Type"
end
