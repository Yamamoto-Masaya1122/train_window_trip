Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: [:new, :create]
  resources :youtube_searchs, only: [:index]
  resource :profile, only: [:show, :edit, :update]
  resources :lines, only: %i[index show] do
    resources :comments
    collection do
      get :update_lines_options
    end
  end
end