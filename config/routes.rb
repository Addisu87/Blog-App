Rails.application.routes.draw do
  # root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :create, :new, :show, :edit, :destroy] do
      # resources :comments, only: [:create, :new, :destroy]
      # resources :likes, only: [:create, :destroy]
    end
  end
end
