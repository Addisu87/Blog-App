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

  resources :users, param: :_user_id
  post 'api/v1/auth/login', to: 'authentication#login'
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do 
      resources :users, only: %i[:index, :show] do
        resources :posts, only: %i[:index, :show] do
          resources :comments, only: %i[:index, :show, :create]
        end
      end
    end
  end

  
  delete '/users/:user_id/posts/:id', to: 'posts#destroy'
  get '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#show'
  delete '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#destroy'
end

