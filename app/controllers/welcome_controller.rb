class WelcomeController < ApplicationController

	def home
		
	end

	def log_in
		render "sign_in"
	end

	def access
		cgc = login_params[:cgc]
		password = login_params[:password]

		if (CPF.valid?(login_params[:cgc]))
			@user = User.find_by(cpf: login_params[:cgc])

			if !@user.nil? 
				if @user.valid_password?(login_params[:password])
					sign_in :user, @user
					redirect_to root_path
				end
			else
				flash[:danger] = "CPF/CNPJ nao cadastrado ou senha invalida"
				redirect_back(fallback_location: sign_in_path)
			end
			
		elsif (CNPJ.valid?(login_params[:cgc]))
			@institution = Institution.find_by(cnpj: login_params[:cgc])

			if !@institution.nil? 
				if @institution.valid_password?(login_params[:password])
					sign_in :institution, @institution
					redirect_to root_path
				end
			else
				flash[:danger] = "CNPJ nao cadastrado ou senha invalida"
				redirect_back(fallback_location: sign_in_path)
			end

		else
			flash[:danger] = "CPF/CNPJ Invalido"
			redirect_back(fallback_location: sign_in_path)
		end 
	end

	def forgot_password
		
	end

	def login_params
		params.permit(:cgc, :password, :authenticity_token, :utf8, :commit)
	end
	
end
