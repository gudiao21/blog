class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  #Por padrão, a Action 'show' renderizará 'app/views/articles/show.html.erb':
  def show
    #'params[:id]' tem que ter sido mencionado em 'routes.rb', em: get"/articles/:id", to: "articles#show"
    #A Action 'show' chama 'Article.find' com o 'id' capturado pelo parâmetro de rota. O 'article' retonado é armazenado na variável de instância '@article', portanto, é acessível pela visualização. Por padrão, a action 'show renderizará 'app/views/articles/show.html.erb'.
    @article = Article.find(params[:id])
  end
  #Agora passamos para o 'C'(Create) do CRUD. Normalmente, em aplicativos da Web, a criação de um novo recurso é um processo de várias etapas. Primeiro, o usuário solicita um formulário para preencher. Em seguida, o usuário envia o formulário. Se não houver erros, o recurso será criado e algum tipo de confirmação será exibida. Caso contrário, o formulário é reexibido com mensagen de erro e o processo é repetido.
  #Em um aplicativ oRails, essas etapas são tratadas convencionalmente pelas ações 'new' e 'create' de um controlador. Vamos adicionar uma implementação típica dessas ações em 'app/controllers/articles_controller.rb, abaixo da ação 'show':
  

end