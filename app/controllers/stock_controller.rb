class StockController < ApplicationController


	def find_stock
		if search_query.empty?
			return handle_error_redirect(error_text: "Please enter a symbol to search", redirect_url: my_portfolio_path)
		end 
		@stock =  Stock.new_lookup(search_query.upcase)
		if @stock.nil?
			return handle_error_redirect(error_text: "Invalid symbol", redirect_url: my_portfolio_path)
		else 
			render 'users/my_portfolio'
		end
	end

	private
	def search_query
		# params.permit(:search)
		params[:stock]
	end
end

