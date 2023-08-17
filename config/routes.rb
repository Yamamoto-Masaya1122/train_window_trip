Rails.application.routes.draw do
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: [:new, :create]
  resources :youtube_searchs, only: [:index]
  resources :search_results, only: [:index, :show]
  resource :profile, only: [:show, :edit, :update]
end