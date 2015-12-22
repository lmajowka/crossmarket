Rails.application.routes.draw do
  match '/:controller/:action', to: 'controller#action', via: :get
  root 'index#index'
end
