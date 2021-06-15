Rails.application.routes.draw do
  root 'posts#index'
  get 'session/login'
  get 'session/create'
  post 'session/create'
  get 'session/logout'
  post 'posts/:id/comment', to: 'posts#comment', as: 'comment'
  
  resources :users
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
