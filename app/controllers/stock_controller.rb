class StockController < ApplicationController
	# protect_from_forgery except: :find_stock

	def find_stock
		if search_query.empty?
			flash.now[:alert] = "Please enter a symbol to search"
			respond_find_stock

		else
			@stock =  Stock.new_lookup(search_query.upcase)
			if @stock.nil?
				flash.now[:alert] = "Invalid symbol"
				respond_find_stock
			else
				respond_find_stock
			end
		end
	end

	private
	def search_query
		# params.permit(:search)
		params[:stock]
	end

	def respond_find_stock
		respond_to do |format|
			format.html { render  'users/my_portfolio' } 
			format.turbo_stream
			return
		end
	end
end

