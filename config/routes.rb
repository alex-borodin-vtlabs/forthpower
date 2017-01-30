Rails.application.routes.draw do
  resources :attachments
  resources :chat_rooms, only: [:new, :create, :show, :index, :edit, :update]
  resources :attachments, only: [:create]
  root 'chat_rooms#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', confirmations: 'users/confirmations' }
  resources :users, only: [:show, :index, :edit, :update]
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
