Rails.application.routes.draw do
  # Defines the root path route ("/")

  root "users#index"
  # resources :users, only: [:index, :show] do
  #   resources :posts, only: [:index, :create, :new, :show, :destroy] do
  #     resources :comments, only: [:create, :new, :destroy]

  #     resources :likes, only: [:create]
  #   end
  # end
  resources :posts do 
    resources :comments 
  end
end
