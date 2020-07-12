class Institutions::InstitutionsController < ApplicationController
	before_action :set_institution, only: [:edit, :update, :show, :destroy]

	def profile
		authorize Institution
	end

	def edit

	end

	def update
		authorize @institution
		if @institution.update(institution_params)
			flash[:sucess] = "Instituicao atualizado com sucesso"
			redirect_to institutions_profile_path(@institution)
		else
			render 'edit'
		end
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