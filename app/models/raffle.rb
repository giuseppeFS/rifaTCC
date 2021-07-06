class Raffle < ApplicationRecord
  belongs_to :institution
  has_many :tickets
  has_many_attached :images
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_type
end