Rails.application.routes.draw do
  namespace :teams do
    get 'participant/new'
    post 'participant/create'
  end

  resources :categories

  resources :flyers
  resources :events do
    post :generate
    resources :teams
  end

  resources :participants

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
