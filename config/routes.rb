Rails.application.routes.draw do
  post    '/teams/:team_id/participant',    controller: 'teams/participant', action: :create,  as: 'teams_participant'
  get     '/teams/participant/new',             controller: 'teams/participant', action: :new,     as: 'new_teams_participant'
  delete  '/teams/:team_id/participant/:id',    controller: 'teams/participant', action: :destroy, as: 'destroy_teams_participant'

  resources :categories, only: [:index, :new, :create, :destroy]
  resources :flyers, only: [:index, :new, :create, :destroy]

  resources :events do
    post :generate
    resources :teams, only: [:index, :destroy]
    resources :participants, only: [:new, :create, :destroy]
  end

  # mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
