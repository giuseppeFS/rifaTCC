class ApplicationController < ActionController::Base
	include Pundit

	protect_from_forgery with: :exception

	def after_sign_in_path_for(resource)
		if resource.instance_of? Admin
			admins_dashboard_root_path
		elsif resource.instance_of? Institution
			institutions_dashboard_root_path
		elsif resource.instance_of? User
			users_dashboard_root_path
		end
	end

	def pundit_user
		if admin_signed_in?
			current_admin
		elsif institution_signed_in?
			current_institution
		elsif user_signed_in?
			current_user
		else
			nil
		end
	end
end
