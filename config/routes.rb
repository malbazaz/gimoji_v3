Rails.application.routes.draw do
  resources :emotions
  resources :occasions
  resources :giftmojis
  resources :users
  resources :sessions

get '/users/:id' => 'users#show'
get '/' =>"application#index"
get '/signup' => 'users#new'
get 'login', to: 'sessions#new'
post '/login' => 'sessions#create'
get  '/logout' => 'sessions#destroy'
post '/logout' => 'sessions#destroy'
  #For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
