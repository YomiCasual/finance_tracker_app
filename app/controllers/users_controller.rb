class UsersController < ApplicationController
  def my_portfolio
	render :my_portfolio,  locals: { stock: nil}
  end
end
