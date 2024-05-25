class BaseController < ActionController::Base
    include Pundit
  
    after_action :verify_authorized, unless: :skip_authorization?
    after_action :verify_policy_scoped_if_needed, unless: :skip_policy_scope?
  
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
    private
  
    def verify_policy_scoped_if_needed
        verify_policy_scoped if action_name.in?(policy_scoped_actions)
    end
  
    def policy_scoped_actions
      [:index, :search]
    end
  
    def skip_authorization?
        devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ || policy_scoped_actions.include?(action_name.to_sym)
    end

    def skip_policy_scope?
        devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
      end
  
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
  end
  