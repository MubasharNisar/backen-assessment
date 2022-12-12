Rails.application.routes.draw do
  # get 'movies/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :movies do
    collection do
      get 'search'
    end
  end
  # Defines the root path route ("/")
  root "movies#index"
end
