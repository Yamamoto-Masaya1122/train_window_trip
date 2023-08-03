Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  root 'static_pages#top'
  resources :users, only: [:new, :create]
end
