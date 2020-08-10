Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  resources :items do
    post 'borrow_item', on: :member
    post 'return_item', on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
