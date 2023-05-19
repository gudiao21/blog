Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #"get '/articles'" é mapeada para(to) a ação 'index' de 'ArticlesController':
  #get "/articles", to: "articles#index"
  
  #Essa 'route'abaixo é outra rota 'get', mas tem algo extra sem seu 'path', o ':id'.Isso designa um parâmetro de rota.Um parâmetro de rota captura um segmento do caminho da solicitação e coloca esse valor no 'Params' Hash, que é acessível pela ação do controlador.Por exemplo, ao lidar com uma solicitação como 'Get http://localhost:3000/articles/1', '1' seria capturado como o valor para ':id', que seria acessível como 'params[:id]' na action show de ArticlesContoller:
  #get"/articles/:id", to: "articles#show"

  #O Rails fornece um método de rotas chamado 'resources', que mapeia todas as rotas convencionais para uma coleção de recursos, como artigos. Portanto, antes de prosseguirmos para as seções 'C', 'U' e 'D', vamos substituir as duas rotas 'get' em 'config/routes.rb' por 'resources':
  
  #Isso abaixo cria 'comments' como um recurso aninhado nos artigos. Está é outra parte da captura da relação herárquica que existe entre 'articles' e 'comments':

  #Após fazer essa alteração abaixo, poderemos criar o 'controler' correspondente através do comando 'rails generate controler Comments' no shell de comando.
  root "articles#index"
  resources :articles do
    resources :comments
  end
end
