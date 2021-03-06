class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def after_sign_in_path_for(resource)
    if current_user.admin?
      rails_admin_path
    else
      root_path
    end
  end


	rescue_from CanCan::AccessDenied do |exception|
	    flash[:error] = "Access denied."
	    flash[:alert] = 'Sorry you are not allowed to do that.'
	    if current_user && current_user.admin?
	      redirect_to :back
	    else
	      redirect_to main_app.root_path
	    end
  	end

end
