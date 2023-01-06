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

		@new_user_stock = UserStock.create(user: current_user, stock_id: stock.id )

		if @new_user_stock
			respond_to do |format|
				flash.now[:notice] = "Stock created successfully"
				format.html
				format.turbo_stream {
					render turbo_stream: turbo_stream.append('stock_list', partial: 'users/shared/stock_list', 
					locals: { stock: stock}
					)
				}
			end
			# respond_with_stream
		else
			flash.now[:alert] = "Could not add stock to portfolio"
			respond_with_stream
		end

	end

	def destroy


		@stock = UserStock.find_by(stock_id: delete_stock_params, user: current_user);
		if !@stock
			flash.now[:alert] = "Cannot find stock"
			respond_with_stream
		end

		p "stock #{@stock}"


		if @stock.destroy
			respond_to do |format|
				flash.now[:notice] = "Stock removed successfully"
				format.turbo_stream {
					render turbo_stream: turbo_stream.remove("stock_list_#{delete_stock_params}", ) }
				format.html { redirect_to my_portfolio_path, notice: "Stock was successfully removed" }
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
