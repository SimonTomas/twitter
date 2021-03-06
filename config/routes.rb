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
    get 'api/news', to: 'tweets#news'
    get 'api/:fecha1/:fecha2', to: 'tweets#date'
    post 'api/tweets/:content', to: 'tweets#create_api_tweet'

    get 'user/:id', to: 'users#show', as: 'profile_user'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
