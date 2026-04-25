Rails.application.routes.draw do
  get 'orders/new'
  get 'orders/create'
  get 'orders/index'
  get 'orders/show'
  devise_for :users

  root "products#index"
  resources :products
  resources :cart_items, only: [:create, :update, :destroy]
  resource :cart, only: [:show]
  resources :orders, only: [:new, :create, :index, :show]
end