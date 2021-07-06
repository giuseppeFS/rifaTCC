class Category < ApplicationRecord
  has_many :raffles
  has_many :subcategories, :class_name => 'Category', foreign_key: 'subcategory_id'
end