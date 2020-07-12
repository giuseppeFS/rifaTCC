class Wallet < ApplicationRecord
  belongs_to :user
  has_many :account_entrys
end