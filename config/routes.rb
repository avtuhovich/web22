Rails.application.routes.draw do
  resources :users
  resources :people

  get 'main/index'
  get 'main/help'
  get 'main/contacts'
  get 'main/about'

  root 'main#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
