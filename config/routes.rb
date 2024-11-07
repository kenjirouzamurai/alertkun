Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index', as: "home_root"
  get "/setup", to: "management#setup"
  # resource :management, only: :show, controller: "management", as: 'management_root'
  # get '/management/*path', to: 'management#show'
  resources :sites do
    member do 
      get :delete
    end
  end

  resources :contacts, only: [:new, :create]
  get '/contacts/thanks', to: 'contacts#thanks'

  resource :home, controller: "home"
  namespace :api, { format: "json" } do
    resource :line_bot, only: [:create], controller: "line_bot"
  end
end
