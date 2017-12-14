Express::Engine.routes.draw do
  root 'channels#index'
  resources :sites
  resources :channels do
    resources :entries
  end
  resources :settings
  post 'change_site'       => 'sites#change_site'
  get 'search'             => 'application#search'
end
