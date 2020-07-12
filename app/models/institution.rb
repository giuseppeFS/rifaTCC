class Institution < ApplicationRecord
  before_save { self.email = email.downcase }

  devise :database_authenticatable

  validates :cnpj, presence: true, 
                   uniqueness: true

  validate :cnpj_valid?

  validates :corporate_name, presence: true,
						                 length: { maximum: 100 }

  # validates :qualification

  # validates :state_registration

  private

  def cnpj_valid?
    if !(CNPJ.new(self.cnpj).valid?)
      errors.add(:cnpj, "CPF invalido")
    end
  end

end