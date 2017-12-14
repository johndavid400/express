Express::Engine.routes.draw do
  root 'channels#index'

  resources :sites

  resources :channels do
    resources :entries
  end

  namespace :api do
    namespace :v1 do
      resources :channels do
        resources :entries
      end
    end
  end

  resources :settings
  post 'change_site'       => 'sites#change_site'
  get 'search'             => 'application#search'
end
