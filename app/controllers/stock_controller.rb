class StockController < ApplicationController
	# protect_from_forgery except: :find_stock

	def find_stock
		if search_query.empty?
			flash.now[:alert] = "Please enter a symbol to search"
			respond_with_stream

		else
			@stock =  Stock.new_lookup(search_query.upcase)
			if @stock.nil?
				flash.now[:alert] = "Invalid symbol"
				respond_with_stream
			else
				respond_with_stream
			end
		end
	end

	private
	def search_query
		# params.permit(:search)
		params[:stock]
	end


end

