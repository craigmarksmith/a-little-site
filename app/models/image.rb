class Image < ActiveRecord::Base
  belongs_to :dig

  has_attached_file :photo,
    :styles => {:thumb  => "100x100",:medium => "200x200",:large => "600x400"},
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :bucket => ENV['S3_BUCKET'],
    :path => ":attachment/:id/:style.:extension"
end