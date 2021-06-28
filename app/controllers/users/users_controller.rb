class Users::UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]

	#
	# Shared Actions
	#
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		authorize User

		if @user.save
			flash[:sucess] = "Usuario criado com sucesso"
		end

		redirect_to users_profile_path(@user)
	end

	def update
		authorize @user
		
		if @user.update(user_params)
			flash[:sucess] = "Usuario atualizado com sucesso"
		end

		redirect_to users_profile_path(@user)
	end

	#
	# User only actions
	#
	def profile
		authorize User
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:cpf,
			:name,
			:email,
			:password,
			:address,
			:number,
			:complement,
			:neighborhood,
			:zipCode,
			:ddd_phone,
			:phone_number,
			:ddd_cellphone,
			:cellphone_number)

	end

end