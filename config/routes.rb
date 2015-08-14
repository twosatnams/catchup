Rails.application.routes.draw do
  root to: 'static_pages#root'

  resources :users, only: [:create]
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: { :format => :json } do
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:create, :update, :destroy, :show]
    resources :likes, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy, :show]
    resources :comments, only: [:create, :update, :show, :destroy]
    resources :mentions, only: [:create, :destroy]
  end
end
