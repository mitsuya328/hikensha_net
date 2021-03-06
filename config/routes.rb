Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',     to: 'static_pages#help'
  get  '/about',    to: 'static_pages#about'
  get  '/contact',  to: 'static_pages#contact'
  get  '/news',     to: 'static_pages#news'
  get  '/signup',   to: 'users#new'
  post '/signup',   to: 'users#create'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: %i(edit)
  resources :password_resets,     only: %i(new create edit update)
  resources :experiments, shallow: true do
    resources :subjects
  end
end