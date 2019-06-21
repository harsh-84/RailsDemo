Rails.application.routes.draw do
  resources :feeds
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

end
