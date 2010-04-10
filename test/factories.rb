require 'factory_girl'

Factory.sequence :dig_name do |n|
  "Dig #{n}"
end

Factory.define :dig do |d|
  d.name{ Factory.next :dig_name }
end

Factory.define :dig_type do |dt|
  dt.name "Dig Type"
end

Factory.sequence :theatre_name do |tn|
  "Theatre #{tn}"
end

Factory.define :theatre do |t|
  t.name{ Factory.next :theatre_name }
end

Factory.define :theatre_distance do
end

Factory.define :tour do
end

