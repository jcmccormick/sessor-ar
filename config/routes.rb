Rails.application.routes.draw do
  resources :reports, only: [:index, :show, :create, :update, :destroy]

  root 'home#index'
end
