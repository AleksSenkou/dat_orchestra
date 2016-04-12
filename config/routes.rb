Rails.application.routes.draw do
  root 'pages#home'

  resources :repertoire, only: :index
  resources :gallery_items, path: 'gallery', only: :index
  resources :members, only: :index
  resources :contacts, only: :index
  resources :messages, only: :create
end
