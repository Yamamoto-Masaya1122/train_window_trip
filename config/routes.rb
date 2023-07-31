Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users, only: [:new, :create]
end
