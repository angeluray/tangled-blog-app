Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :post]

  namespace :api, defaults: { format: :json } do
    post 'auth/login', to: 'authentication#login'
    resources :users, only: %i[create update destroy] do
      resources :posts, only: [:index, :show] do
        resources :comments, only: [:index, :create]
    end
   end
  end
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :new, :destroy] do
      resources :comments, only: [:create, :new, :destroy]
        resources :likes, only: [:create]
    end
  end
    root to: 'users#index'
end
