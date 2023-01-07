class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?



	def handle_error_redirect(error_text: "An error occured", redirect_url: root_path, is_redirect: true)
		if is_redirect
			flash[:alert] = error_text
			redirect_to redirect_url, status: :unprocessable_entity
		else
			flash.now[:alert] = error_text
			render redirect_url,  status: :unprocessable_entity
		end
	end


	def respond_with_stream(path: 'users/my_portfolio' )
		respond_to do |format|
			format.html { render path } 
			format.turbo_stream
			return
		end
	end

	protected
	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
	end


end
