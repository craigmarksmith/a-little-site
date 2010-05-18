class Image < ActiveRecord::Base
  belongs_to :dig

  has_attached_file :photo,
    :styles => {:thumb  => "100x100",:medium => "200x200",:large => "600x400"},
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :path => ":attachment/:id/:style.:extension",
    :bucket => 'digsimages'
end