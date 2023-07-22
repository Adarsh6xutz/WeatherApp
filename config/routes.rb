Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'

  get '/weather', to: 'weather#show'

  delete '/logout', to: 'users#destroy_session', as: :logout
end
