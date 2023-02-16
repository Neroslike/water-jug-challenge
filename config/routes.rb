Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # This is the main route where the API will return the steps to solve the puzzle
  # given a set of parameters x, y and z.
  get '/result/:x/:y/:z', to: 'waterjug#result'
end
