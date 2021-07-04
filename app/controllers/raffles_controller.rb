class RafflesController < ApplicationController
	before_action :set_raffle, only: [:edit, :update, :show, :destroy]

	def index
	  @raffles = Raffle.all
	end

	def new
	  @raffle = Raffle.new
	end

	def edit
	  
	end

	def create
	  render plain: params[:raffle].inspect
	  @raffle = Raffle.new(raffle_params)
	  if @raffle.save
	  	flash[:sucess] = "Usuario criado com sucesso"
	  	redirect_to raffles_show(@raffle)
	  else
	  	render 'new'
	  end
	end

	def update
	  if @raffle.update(raffle_params)
	  	flash[:sucess] = "Usuario atualizado com sucesso"
	  	redirect_to raffles_show(@raffle)
	  else
	  	render 'edit'
	  end
	end

	def show
	  
	end

	def destroy
	  
	  @raffle.destroy
	  flash[:danger] = "Usuario deletado com sucesso"
	  redirect_to raffles_path
	end

	private

	  def set_raffle
	  	@raffle = Raffle.find(params[:id])
	  end

	  def raffle_params
	  	params.require(:raffle).permit(:description)

	  end

end