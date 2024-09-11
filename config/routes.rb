Rails.application.routes.draw do
  devise_for :users
  resources :todo_lists do
    resources :tasks
   end
  root "todo_lists#index"
end
