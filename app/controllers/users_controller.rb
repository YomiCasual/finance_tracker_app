class UsersController < ApplicationController
  def my_portfolio
	@user_tracked_stocks = current_user.stocks
	render :my_portfolio,  locals: { stock: nil}
  end
end
