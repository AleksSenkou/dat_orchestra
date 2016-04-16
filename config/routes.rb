Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'pages#home'

  get 'set_locale', to: 'pages#set_locale'

  resources :repertoire, only: :index

  resources :gallery_items, path: 'gallery', only: :index

  resources :members, only: :index

  resources :contacts, only: :index

  resources :messages, only: :create

  resources :riders, only: :index do
    member do
      get :download
    end
  end
end
