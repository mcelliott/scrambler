Rails.application.routes.draw do

  resources :pages

  resources :scoring, controller: :handicaps, only: [:index, :edit, :update], as: :scoring
  resources :event_scores, only: [:update]
  resources :flyer_imports, only: [:create, :new]
  resources :settings, only: [:index, :update]
  resources :tenants, only: [:index, :new, :update, :edit, :destroy]

  post    '/teams/:team_id/participant',        controller: 'teams/participant', action: :create,  as: 'teams_participant'
  get     '/teams/participant/new',             controller: 'teams/participant', action: :new,     as: 'new_teams_participant'
  delete  '/teams/:team_id/participant/:id',    controller: 'teams/participant', action: :destroy, as: 'destroy_teams_participant'

  resources :categories, only: [:index, :update, :new, :edit, :create, :destroy]
  resources :flyers, only: [:index, :update, :new, :edit, :create, :destroy]

  resources :events do
    post :generate
    get :generate_mixed
    resources :teams, only: [:index, :destroy]
    resources :participants, only: [:new, :create, :show, :destroy]
    resources :payments, only: [:index, :show, :edit, :update, :destroy]
    resources :expenses, only: :index
    resources :categories, only: :destroy, controller: 'events/categories'
    resource :email, only: [:new, :create], controller: 'events/emails'
  end

  get 'events/teams/:uuid', controller: 'teams', action: :team_view, as: 'team_view'

  root to: 'visitors#index'
  devise_for :users, controllers: { invitations: :invitations }

  resources :users

  mount Sidekiq::Web, at: '/sidekiq' unless Rails.env.production?
end
