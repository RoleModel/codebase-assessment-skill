Rails.application.routes.draw do
  resource :session, only: %i[new create]
  resources :orders
  root "orders#index"
end
