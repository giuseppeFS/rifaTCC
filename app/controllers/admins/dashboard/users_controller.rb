class Admins::Dashboard::UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy]

	def index
		authorize User
		@users = User.paginate(page: params[:page], per_page: 1)
	end


	def new
		@user = User.new
	end

	def edit
		authorize User
	end

	def create
		@user = User.new(user_params)
		authorize @user
		if @user.save
			flash[:sucess] = "Usuario criado com sucesso"
			redirect_to users_path(@user)
		else
			render 'new'
		end
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

	def show
		authorize User
	end

	def destroy
		authorize User
		@user.destroy
		flash[:danger] = "Usuario deletado com sucesso"
		redirect_to users_path
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