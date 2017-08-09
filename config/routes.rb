Express::Engine.routes.draw do
  resources :channels
  resources :entries
  resources :settings
end
