Express::Engine.routes.draw do
  root 'entries#index'
  resources :channels
  resources :entries
  resources :settings
  get 'search' => 'application#search'
end
