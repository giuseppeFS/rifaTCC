module ApplicationHelper
	def controller?(*controller)
		controller.include?(params[:controller])
	end

	def action?(*action)
		action.include?(params[:action])
	end

  def is_active(controller)       
    controller_name == controller ? "active" : nil     
  end

  def is_active_action(action)       
    action_name == action ? "active" : nil     
  end
end
