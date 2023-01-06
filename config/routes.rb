Rails.application.routes.draw do
  resources :user_stocks
  get 'my_portfolio', to: "users#my_portfolio"
  devise_for :users
  get "stock/search", to: "stock#find_stock"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root  "users#my_portfolio"

#   resources :stocks

end
