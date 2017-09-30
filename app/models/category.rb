class Category < ApplicationRecord
  #associations
  has_many :posts
  has_many :sources
  has_many :sub_categories, class_name: Category, foreign_key: :parent_id
  # belongs_to :parent, class_name: Category
end
