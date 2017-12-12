Express::Engine.routes.draw do
  root 'entries#index'
  resources :channels
  resources :entries
  resources :settings
  resources :sites
  post 'change_site'       => 'sites#change_site'
  get 'search'             => 'application#search'
end
