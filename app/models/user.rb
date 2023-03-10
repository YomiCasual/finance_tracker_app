class User < ApplicationRecord
	has_many :user_stocks
	has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	def under_track_stock_limit?
		stocks.count <= 10
	end
	
	def stock_already_tracked?(ticker_symbol)
		!stocks.find_by(ticker: ticker_symbol).nil?
	end

	def can_track_stock?(ticker_symbol)
		under_track_stock_limit? && !stock_already_tracked?(ticker_symbol)
	end

	def full_name
		if first_name || last_name
		"#{first_name} #{last_name}"
		else 
		email
		end
	end
end
