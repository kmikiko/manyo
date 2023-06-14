Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks 
  resources :users, only: [:new, :create, :edit, :update, :destroy, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users 
  end
end
