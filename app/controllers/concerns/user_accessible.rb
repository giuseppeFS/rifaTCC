# ../controllers/concerns/accessible.rb
module UserAccessible
	extend ActiveSupport::Concern
	included do
		before_action :check_user
	end

	protected
	def check_user
		if !user_signed_in?
			redirect_to root_path, error: 'Sem autorizacao para acessar'
		end
	end

end