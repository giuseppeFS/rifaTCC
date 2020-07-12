class Users::UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]

	def profile
		authorize User
	end

	def update
		authorize @user
		if @user.update(user_params)
			flash[:sucess] = "Usuario atualizado com sucesso"
			redirect_to users_path(@user)
		else
			render 'edit'
		end
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