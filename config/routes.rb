Rails.application.routes.draw do
  resources :flyers

  resources :skills

  resources :teams

  resources :events

  resources :participants

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
