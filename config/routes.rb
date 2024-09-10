Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists do
    resources :tasks, only: [ :create, :edit, :show, :new ]
   end
  resources :tasks, only: [ :update, :index, :new, :show, :create ]
  root "todo_lists#index"
end
