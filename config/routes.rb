Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers
  mount RailsAdmin::Engine => '//admin', as: 'rails_admin'
  get 'home/index'
  devise_for :users
  namespace :api, :defaults => {:format => 'json'} do
    devise_scope :user do
        post 'auth/sign_in', to: 'sessions#create'
        delete 'auth/sign_out', to: 'sessions#destroy'
    end
    namespace :v1 do
      get '/customers', to: 'customers#index'
    end
  end
  root to: "home#index"
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
end
