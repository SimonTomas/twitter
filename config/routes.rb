Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    resources :likes
    member do
      get :retweet
    end
  end
  
    post 'user/:user_id', to: 'friends#create', as: 'friend_create'
    delete 'user/:user_id', to: 'friends#destroy', as: 'friend_destroy'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
