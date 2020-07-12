# ../controllers/concerns/accessible.rb
module InstitutionAccessible
	extend ActiveSupport::Concern
	included do
		before_action :check_institution
	end

	protected
	def check_institution
		return unless institution_signed_in?
		redirect_to root_path, error: 'Sem autorizacao para acessar'
	end

end