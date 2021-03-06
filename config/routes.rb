Statusboard::Application.routes.draw do
  
  devise_for :users
  
  root to: 'pages#login'
  get 'home' => 'boards#index', :as => 'home'
  
  resources :boards do
    member do
      get 'delete'
      get 'share'
    end
  end
  
  resources :statuses
  
  resources :items do
    member do
      post 'move'
    end
  end

  post '/feedback' => 'feedback#create'

end
