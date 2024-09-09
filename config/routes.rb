Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists do
    resources :tasks, only: [ :create, :edit, :show ]
   end
  resources :tasks, only: [ :update, :index, :new ]
  root "todo_lists#index"
end
