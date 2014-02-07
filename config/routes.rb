SecretShareAjax::Application.routes.draw do
  resources :users, :only => [:create, :new, :show, :index] do
    member do
      resources :secrets, only: [:new]
      resources :friendships, only: [:create]
    end
  end
  resources :friendships, only: [:destroy]
  resources :secrets, only: [:create]
  resource :session, :only => [:create, :destroy, :new]

  delete "users/:id/friendships", to: "friendships#destroy", as: "friendships"

  root :to => "users#show"
end
