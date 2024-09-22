Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists
  resources :tasks
  resources :shared_todo_lists, only: [ :index, :create, :destroy, :show ]
  root "todo_lists#index"
end
