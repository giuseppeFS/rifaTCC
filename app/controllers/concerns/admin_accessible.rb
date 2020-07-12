# ../controllers/concerns/accessible.rb
module AdminAccessible
	extend ActiveSupport::Concern
	included do
		before_action :check_admin
	end

	protected
	def check_admin
		if !admin_signed_in?
			redirect_to root_path, error: 'Sem autorizacao para acessar'
		end
	end

end