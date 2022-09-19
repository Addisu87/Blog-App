Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do 
      resources :comments, only: [:create, :destroy] do 
        resources :likes, only: [:create, :destroy]
      end
    end
  end
end
