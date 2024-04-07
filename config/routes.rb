Rails.application.routes.draw do
  devise_for :clients, controllers: { registrations: 'clients/registrations', sessions: 'clients/sessions' }
  devise_for :employees, controllers: { registrations: 'employees/registrations', sessions: 'employees/sessions' }

  post 'services/:id/add_to_favorites', to: 'services#add_to_favorites', as: 'add_to_favorites_service'

  devise_scope :client do
    get '/clients/sign_up', to: 'clients/registrations#new'
  end

  devise_scope :employee do
    get '/employees/sign_up', to: 'employees/registrations#new'
  end

  get '/select_registration', to: 'index#select_type', as: :select_registration

  get '/services/by_type/:service_type/:rand', to: 'services#by_type', as: 'services_by_type'

  root to: 'index#home'
  resources :client_likes
  resources :orders
  resources :services
  resources :client_profiles
  resources :employee_profiles
  resources :comments
  resources :urgencies
  resources :statuses
  resources :specializations
  resources :difficulties
  resources :addresses

  get 'search', to: 'services#search'

  get 'calendar', to: 'client_profiles#calendar', as: 'calendar'
  get 'employee_calendar', to: 'employee_profiles#calendar', as: 'employee_calendar'

  get 'up' => 'rails/health#show', as: :rails_health_check
end
