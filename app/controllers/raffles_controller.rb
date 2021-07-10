class RafflesController < ApplicationController
	before_action :set_raffle, only: [:edit, :update, :show, :destroy]

	def index
	  @validation = validate_filters

	  if @validation.empty?
	  	@raffles = get_filters.paginate(page: params[:page], per_page: 10)
	  else
	  	@raffles = Raffle.only_active.paginate(page: params[:page], per_page: 10)
	  end
	end

	def show
	  
	end


	private

	  def set_raffle
	  	@raffle = Raffle.find(params[:id])
	  end

	  def filter_pararms
	  	params.permit(
        :category_id,
        :condition_id,
        :delivery_type_id,
        :title,
        :prize,
        :cnpj,
        :draw_date_initial,
        :draw_date_final,
        :unit_value_min,
        :unit_value_max 
        )
	  end

	  def validate_filters
	  	errors = {}

	  	if params.key?(:draw_date_initial) && !params[:draw_date_initial].empty?
	  		begin
	  			DateTime.strptime(params[:draw_date_initial], '%d/%m/%Y')
	  		rescue StandardError
	  			errors[:draw_date_initial] = "Data inválida"
	  		end
	  	end

	  	if params.key?(:draw_date_final) && !params[:draw_date_final].empty?
	  		begin
	  			DateTime.strptime(params[:draw_date_final], '%d/%m/%Y')
	  		rescue StandardError
	  			errors[:draw_date_final] = "Data inválida"
	  		end
	  	end

	  	errors
	  end

	  def get_filters
	  	result = Raffle.only_active

	  	if params.key?(:category_id) && !params[:category_id].empty?
	  		result = result.where('category_id = ? ', filter_pararms[:category_id].to_f)
	  	end

	  	if params.key?(:condition_id) && !params[:condition_id].empty?
		  	result = result.where('condition_id = ? ', filter_pararms[:condition_id].to_f)
	  	end

	  	if params.key?(:delivery_type_id) && !params[:delivery_type_id].empty?
	  		result = result.where('delivery_type_id = ? ', filter_pararms[:delivery_type_id].to_f)
		end

        if params.key?(:title) && !params[:title].empty?
        	result = result.where('UPPER(title) LIKE ? ', '%' + filter_pararms[:title].upcase + '%')
    	end

        if params.key?(:prize) && !params[:prize].empty?
        	result = result.where('UPPER(prize) LIKE ? ', '%' + filter_pararms[:prize].upcase + '%')
    	end

        if params.key?(:cnpj) && !params[:cnpj].empty?
        	result = result.joins(:institution).where('cnpj = ? ', filter_pararms[:cnpj].tr('^0-9', ''))
        end

	    if params.key?(:draw_date_initial) && params.key?(:draw_date_final) &&
	       !params[:draw_date_initial].empty? && !params[:draw_date_final].empty?
			result = result.where('draw_date BETWEEN ? AND ? ', DateTime.strptime(params[:draw_date_initial], '%d/%m/%Y'), DateTime.strptime(params[:draw_date_final], '%d/%m/%Y'))
		elsif params.key?(:draw_date_initial) && !params[:draw_date_initial].empty? 
			result = result.where('draw_date >= ? ', DateTime.strptime(params[:draw_date_initial], '%d/%m/%Y'))
		elsif params.key?(:draw_date_final) && !params[:draw_date_final].empty?
			result = result.where('draw_date <= ? ', DateTime.strptime(params[:draw_date_final], '%d/%m/%Y'))
	    end

	    if params.key?(:unit_value_min) && params.key?(:unit_value_max) &&
	       !params[:unit_value_min].empty? && !params[:unit_value_max].empty?
	    	result = result.where('unit_value BETWEEN ? AND ? ', params[:unit_value_min].to_f, params[:unit_value_max].to_f)
	    elsif params.key?(:unit_value_min) && !params[:unit_value_min].empty?
	    	result = result.where('unit_value >= ? ', params[:unit_value_min].to_f)
	    elsif params.key?(:unit_value_max) && !params[:unit_value_max].empty?
	    	result = result.where('unit_value <= ? ', params[:unit_value_max].to_f)
	    end

	    result
	  end

end