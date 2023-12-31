Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'static_pages#top'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :likes, only: %i[create destroy]
  resources :videos, only: %i[index]
  resource :profile, only: %i[show edit update]
  resources :lines, only: %i[index show] do
    resources :rooms, only: %i[new create]
    collection do
      get :update_lines_options
      get :search
    end
  end
  resources :rankings, only: %i[index]
  resources :password_resets
  resources :rooms, only: %i[index show] do
    resources :comments
  end
  namespace :admin do
    root "dashboards#index"
    resource :dashboard, only: %i[index]
    get 'login' => 'user_sessions#new', :as => :login
    post 'login' => "user_sessions#create"
    delete 'logout' => 'user_sessions#destroy', :as => :logout
    resources :users, only: %i[index show edit update destroy]
    resources :comments, only: %i[index show edit update destroy]
  end
end