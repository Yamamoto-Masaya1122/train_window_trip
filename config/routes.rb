Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'static_pages#top'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :likes, only: %i[create destroy]
  resources :videos, only: %i[index]
  resource :profile, only: %i[show edit update]
  resources :lines, only: %i[index show] do
    resources :comments
    collection do
      get :update_lines_options
      get :search
    end
  end
  resources :like_rankings, only: %i[index]
end