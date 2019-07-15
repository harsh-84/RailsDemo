Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "/contacts/:importer/callback" => "friendships#contacts_callback"
  get "/contacts/failure" => "friendships#contacts_callback"
  get "/oauth2callback" => "friendships#contacts_callback"

  resources :friendships do  
    patch "accept_request" => "friendships#accept_request"
    patch "reject_request" => "friendships#reject_request"
  end 

  get "friend_list" => "friendships#friend_list"
  resources :feeds
  devise_for :users, controllers: { account_update: "users/registrations", sign_up:"users/registrations",omniauth_callbacks: 'users/omniauth' }

 
  resources :user
  resources :bookmarks, only: [:create, :destroy, :index]

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root "feeds#index"
  end
  devise_scope :user do
    root to: "devise/sessions#new"
  end
 
end
