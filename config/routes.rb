Rails.application.routes.draw do

  resources :event_scores, only: [:update]
  resources :flyer_imports, only: [:create, :new]
  resources :settings, only: [:index, :update]

  post    '/teams/:team_id/participant',        controller: 'teams/participant', action: :create,  as: 'teams_participant'
  get     '/teams/participant/new',             controller: 'teams/participant', action: :new,     as: 'new_teams_participant'
  delete  '/teams/:team_id/participant/:id',    controller: 'teams/participant', action: :destroy, as: 'destroy_teams_participant'

  resources :categories, only: [:index, :update, :new, :edit, :create, :destroy]
  resources :flyers, only: [:index, :update, :new, :edit, :create, :destroy]

  resources :events do
    post :generate
    put :email
    resources :teams, only: [:index, :destroy]
    resources :participants, only: [:new, :create, :destroy]
  end

  get 'events/teams/:uuid', controller: 'teams', action: :team_view, as: 'team_view'

  # mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users

  mount Sidekiq::Web, at: '/sidekiq' unless Rails.env.production?
end
