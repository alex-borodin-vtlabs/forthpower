Rails.application.routes.draw do
  resources :chat_rooms, only: [:new, :create, :show, :index]
  root 'chat_rooms#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations' }
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
