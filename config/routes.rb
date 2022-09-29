Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments
      resources :likes
    end
  end

  

  delete '/users/:user_id/posts/:id', to: 'posts#destroy'
  get '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#show'
  delete '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#destroy'
end

