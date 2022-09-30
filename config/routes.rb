Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments
      resources :likes
    end
  end

  namespace :api do
    namespace :v1 do 
      resources :users, only: [:index] do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:index, :show, :create]
        end
      end
    end
  end

  
  delete '/users/:user_id/posts/:id', to: 'posts#destroy'
  get '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#show'
  delete '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#destroy'
end

