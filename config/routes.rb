Rails.application.routes.draw do
  devise_for :users

  root "products#index"
  resources :products
  resources :cart_items, only: [:create, :destroy]
  resource :cart, only: [:show]
end