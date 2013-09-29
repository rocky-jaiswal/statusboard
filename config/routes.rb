Statusboard::Application.routes.draw do
  devise_for :users
  root to: 'pages#login'
  get 'home' => 'boards#index', :as => 'home'
  resources :boards
  resources :statuses
end
