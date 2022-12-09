Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
  resources :posts
  resources :comments, only: [:new, :create, :destroy]
  resources :likes, only: [:new, :create]
  # Defines the root path route ("/")
  root "users#show"
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, format: :json do
          resources :comments, format: :json
        end
      end
    end
  end
  
end
