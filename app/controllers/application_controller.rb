class ApplicationController < ActionController::Base
	before_action :authenticate_user!


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


end
