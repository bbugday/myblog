Rails.application.routes.draw do
  devise_for :users
  resources :articles
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :articles do
    resources :comments
  end
  resources :articles do
    resources :likes
  end
  resources :articles do
    resources :dislikes
  end
  resources :articles do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  resources :tags
end
