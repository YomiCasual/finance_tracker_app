Rails.application.routes.draw do
  get 'my_portfolio', to "users#my_portfolio"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index' 

  resources :stocks

end
