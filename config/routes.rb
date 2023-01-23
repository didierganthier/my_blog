Rails.application.routes.draw do
  get 'users/:id', to: 'users#show'
  get 'users/:id/posts', to: 'posts#index'
  get 'users/:user_id/posts/:id', to: 'posts#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'users#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
