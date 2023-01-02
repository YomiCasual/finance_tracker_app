class Stock < ApplicationRecord


	def self.new_lookup(ticker_symbol)
		client = IEX::Api::Client.new(
			publishable_token: Rails.application.credentials.iex[:publishable_token],
			secret_token: Rails.application.credentials.iex[:secret_token],
			endpoint: 'https://cloud.iexapis.com/v1'
		  )
		begin 
			last_price = client.quote(ticker_symbol).latest_price
			name = client.company(ticker_symbol).company_name
			new(ticker: ticker_symbol, name: name, last_price: last_price)
		rescue => exception
		    return nil
		end
	end
end
