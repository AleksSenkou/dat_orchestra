Rails.application.routes.draw do
  root 'pages#home'

  resources :repertoire, only: :index
  resources :gallery_items, only: :index
end
