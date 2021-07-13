Rails.application.routes.draw do

  root 'repositories#index'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :user_searches
  resources :authentications, param: :_username, only: [:create]

end
