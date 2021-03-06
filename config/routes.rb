Rails.application.routes.draw do
  get 'chats/show'
  devise_for :users
  root to: "homes#top"

  get "search" => "searches#search"

  get "/tweets/category/:id" => "tweets#category"

  resources :tweets do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    delete :followers, on: :member
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  #通知機能
  resources :notifications, only: [:index, :destroy]

  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
end
