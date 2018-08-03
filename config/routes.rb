Rails.application.routes.draw do
  get     '/login',   to: 'sessions#new'
  post     'login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  get    '/signup',   to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lessons do
    resources :lesson_words
  end
  
  resources :categories 
  root   'static_pages#home'
  
  resources :users do
    member do
     get :following, :followers
    end 
  end
  resources :relationships,only:[:create,:destroy]
  namespace :admin do
    resources :categories do
      resources :words do
        resources :word_answers
      end
    end
  end
end
