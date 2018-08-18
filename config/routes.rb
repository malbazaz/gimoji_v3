Rails.application.routes.draw do
  resources :emotions
  resources :occasions
  resources :giftmojis
  resources :users
  resources :sessions

  resources :users, only: [:show] do 
  	resources :giftmojis, only: [:show, :index, :new]
  end 


get '/users/:id' => 'users#show'
get '/' =>"application#index"
get '/signup' => 'users#new'
get 'login', to: 'sessions#new'
post '/login' => 'sessions#create'
get  '/logout' => 'sessions#destroy'
post '/logout' => 'sessions#destroy'

post '/giftmoji/:id/buy' => 'users#update'

  #Nested resource for (Occasion - Gimojis)
 # resources :occasions, only [:show, :index] do 
 #   resources :giftmojis, only [:show, :index]
 # end 

  #Nested resource (User -> Gimojis) ??
  #For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
