Rails.application.routes.draw do
  resources :users do
    resources :posts, only: [:index, :show, :create, :new] do
      resources :comments, only: [:create]
    end
  end  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'users#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
