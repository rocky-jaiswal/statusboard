Statusboard::Application.routes.draw do
  devise_for :users
  root to: 'pages#login'
  get 'home' => 'pages#home', :as => 'home'
end
