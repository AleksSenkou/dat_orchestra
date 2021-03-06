Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'pages#home'

  get 'set_locale', to: 'pages#set_locale'
  get 'about_us', to: 'pages#about_us'
  get 'viewer', to: 'pages#viewer'

  resources :repertoire, only: :index

  resources :gallery_items, path: 'gallery', only: :index

  resources :members, only: :index

  resources :contacts, only: :index

  resources :messages, only: :create

  resources :member_instruments, only: [:create, :destroy]
  resources :compositions_members, only: [:create, :destroy]

  resources :riders, only: :index do
    member do
      get :download
    end
  end
end
