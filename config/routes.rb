Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: "registrations", omniauth_callbacks: 'users/omniauth_callbacks'}          
  resources :users, only: [:index, :show] do
    get 'friends'
    
  end
  resources :likes, only: [:create, :destroy]
  get 'likes', to: 'posts#index'

  
  resources :posts do
    resources :comments
  end

  

  

  get '/friends', to: 'users#friends', as: :friends
  #scope '/friends', as: :friends do
    #get 'find', to: 'users#find_friends'
    #get 'requests', to: 'users#friend_requests'
  #end
  resources :requests, only: :create do 
    member do
      post 'confirm' 
      delete 'declined'
    end
  end

  
  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

  authenticated :user do
    root to: "users#show", as: :authenticated_root
  end

 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
