class AccountEntry < ApplicationRecord
  belongs_to :wallet

  def approved?
  	self.approved
  end
end
