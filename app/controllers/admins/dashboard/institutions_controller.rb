class Admins::Dashboard::InstitutionsController < ApplicationController
	before_action :set_institution, only: [:edit, :update, :show, :destroy]

	def index
		authorize Institution
		@institutions = Institution.paginate(page: params[:page], per_page: 1)
	end

	def institutions_approval
		authorize Institution
		@institutions = Institution.where(:status => false).paginate(page: params[:page], per_page: 1)
	end	

	def aprove_institution
		authorize Institution
		@institution = Institution.find(params[:id])

		if @institution.toggle(:status).save
			flash[:sucess] = "Instituicao aprovada"
		else
			flash[:danger] = "Problema ao aprovar Instituicao"
		end

		redirect_to admins_dashboard_institutions_path
	end

	def new
		@institution = Institution.new
	end

	def edit

	end

	def create
		@institution = Institution.new(institution_params)
		if @institution.save
			flash[:sucess] = "Instituicao criado com sucesso"
			redirect_to institutions_path(@institution)
		else
			render 'new'
		end
	end

	def update
		authorize @institution
		if @institution.update(institution_params)
			flash[:sucess] = "Instituicao atualizado com sucesso"
			redirect_to institutions_path(@institution)
		else
			render 'edit'
		end
	end

	def show

	end

	def destroy
		authorize institution
		@institution.destroy
		flash[:danger] = "Instituicao deletado com sucesso"
		redirect_to institutions_path
	end

	private

	def set_institution
		@institution = Institution.find(params[:id])
	end

	def institution_params
		params.require(:institution).permit(
			:cnpj,
			:email,
			:password,
			:corporate_name,
			:social_reason,
			:address,
			:number,
			:complement,
			:neighborhood,
			:zipCode,
			:ddd_phone,
			:phone_number,
			:ddd_phone2,
			:phone_number2,
			:bank_number,
			:agency_number,
			:account_number,
			:qualification
			)

	end

end