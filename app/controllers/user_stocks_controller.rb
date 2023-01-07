class UserStocksController < ApplicationController

	def create
		stock = Stock.find_by(ticker: create_user_stock_params)
		if !stock
			
			stock = Stock.new_lookup(create_user_stock_params.upcase)
			if stock.nil?
				flash.now[:alert] = "Invalid symbol"
				respond_with_stream
			else
				stock.save()
			end
		end

		existing_stock = UserStock.find_by(user: current_user, stock: stock )  

		
		if existing_stock
			p "existing_stock #{existing_stock}"
			flash.now[:alert] = "Stock already tracked"
			respond_with_stream
			return
		end

		@new_user_stock = UserStock.create(user: current_user, stock_id: stock.id )

		@stock = stock

		if @new_user_stock
			respond_to do |format|
				flash.now[:notice] = "Stock added successfully"
				format.html
				format.turbo_stream
			end
		else
			flash.now[:alert] = "Could not add stock to portfolio"
			respond_with_stream
			return
		end

	end

	def destroy

		@stock = UserStock.find_by(stock_id: delete_stock_params, user: current_user);
		@params =delete_stock_params
		if !@stock
			flash.now[:alert] = "Cannot find stock"
			respond_with_stream
		end

		if @stock.destroy
			respond_to do |format|
				flash.now[:alert] = "Stock removed successfully"
				format.html 
				format.turbo_stream 
			end
		else
			flash.now[:alert] = "Could not remove stock"
			respond_with_stream
		end
	end

	private
	def create_user_stock_params
		params[:ticker]
	end

	def delete_stock_params
		params[:id]
	end
	
end
