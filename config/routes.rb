Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: "movies#index"
  get '/movies/upcoming_movies', to: 'movies#upcoming_movies'
  get '/movies/recent_movies', to: 'movies#recent_movies'
  get '/search', to: 'movies#search'
  
  resources :movies do
    resources :reviews 
  end

end
