Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks',
               sessions: 'users/sessions'
             }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users do
    resources :posts, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :posts, only: [:index, :show]
  resources :requests, only: [:create, :destroy]
  resources :followings, only: [:create, :destroy]


  # Defines the root path route ("/")
  root "posts#index"
end
