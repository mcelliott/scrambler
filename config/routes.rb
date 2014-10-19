Rails.application.routes.draw do
  resources :categories

  resources :flyers

  resources :teams

  resources :events do
    post :generate
  end

  resources :participants

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
