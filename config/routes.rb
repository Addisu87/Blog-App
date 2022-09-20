Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "users#index"
    resources :posts do 
      resources :comments
    end
end
