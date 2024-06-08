Rails.application.routes.draw do
  root 'home#index'
  get 'search', to: 'home#search', as: 'search'

  devise_for :users
  resources :users, only: [:show] do
    resources :collections, except: [:index, :show]
  end
  resources :tickets,only: [:new, :create, :index]
  get 'create_support_ticket', to: 'tickets#new'
  get 'user_tickets', to: 'tickets#index'
  resources :collections do
    resources :items do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

  resources :categories
  resources :tags, only: :index

  namespace :admin do
    resources :users, only: [:index, :destroy] do
      member do
        patch :block
        patch :unblock
        patch :make_admin
        patch :remove_admin
      end
    end
  end
  
end
