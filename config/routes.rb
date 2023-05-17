Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #"get '/articles'" é mapeada para(to) a ação 'index' de 'ArticlesController':
  get "/articles", to: "articles#index"
  #Essa 'route'abaixo é outra rota 'get', mas tem algo extra sem seu 'path', o ':id'.Isso designa um parâmetro de rota.Um parâmetro de rota captura um segmento do caminho da solicitação e coloca esse valor no 'Params' Hash, que é acessível pela ação do controlador.Por exemplo, ao lidar com uma solicitação como 'Get http://localhost:3000/articles/1', '1' seria capturado como o valor para ':id', que seria acessível como 'params[:id] na action show de ArticlesContoller.
  get"/articles/:id", to: "articles#show"
end
