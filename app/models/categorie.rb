class Categorie < ApplicationRecord
  has_many :raffles
  belongs_to :parent, :class_name => 'Categorie'
end