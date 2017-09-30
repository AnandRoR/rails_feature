class Post < ApplicationRecord
  #associations
  has_many :comments
  belongs_to :category
  #uploader
  mount_uploader :image, PostImageUploader
end
