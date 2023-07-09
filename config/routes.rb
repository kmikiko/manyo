Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks 
  resources :users, only: [:new, :create, :edit, :update, :destroy, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :labellings, only: [:new, :create, :destroy]
  namespace :admin do
    root to: 'admin/users#index'  #追記
    resources :users
    resources :labels
  end
  resources :notifications,only: [:index]
end
