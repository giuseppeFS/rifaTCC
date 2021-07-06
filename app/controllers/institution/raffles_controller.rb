class Institution::RafflesController < ApplicationController
	before_action :set_raffle, only: [:edit, :update, :show, :destroy]

	def index
	  @institution = pundit_user
	  @raffles = @institution.raffles.paginate(page: params[:page], per_page: 10)
	end

	def new
	  @raffle = Raffle.new
	end

	def edit
	  
	end

	def create
	  @raffle = Raffle.new(raffle_params)

	  authorize @raffle, policy_class: RafflePolicy

	  if @raffle.save
	  	redirect_to :institution_raffles, :notice => "Rifa criada com sucesso"
	  else
		respond_to do |format|
		format.json {render :json => {:model => @raffle.class.name.downcase, :error => @raffle.errors.as_json}, :status => 422}
		format.html {render 'new'}
		end
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
	  	params.require(:raffle).permit(
        :title,
        :description,
        :prize,
        :prize_description,
        :condition,
        :delivery,
        :unit_value,
        :tickets_number,
        :draw_date
		)
	  end

end