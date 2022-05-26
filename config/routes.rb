Rails.application.routes.draw do
  get 'photo/index'
  get 'photo/upload'
  post 'photo/upload'
  post 'photo/search'
  post 'photo/like'
  post 'photo/agency'
  post 'photo/bias'

  root 'main#index'

  get 'main/index'
  get 'main/about'

  get 'sessions/index'
  post 'sessions/new'
  post 'sessions/create'
  get 'sessions/destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
