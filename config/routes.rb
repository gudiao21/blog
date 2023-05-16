Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #"get '/articles'" é mapeada para a ação 'index' de 'ArticlesController':
  get "/articles", to: "articles#index"
end
