class ApplicationController < ActionController::Base
	before_action :authenticate_user!


	def handle_error_redirect(error_text: "An error occured", redirect_url: root_path)
		flash[:alert] = error_text
		redirect_to redirect_url, status: :unprocessable_entity
	end
end
