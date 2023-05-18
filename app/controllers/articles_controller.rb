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
  def new #Por padrão essa action 'new' vai renderizar:'app/views/articles/new.html.erb'
    @article = Article.new
  end

  def create
    @article = Article.new(title: "...", body: "...")

    if @article.save
      redirect_to @article #Se o 'article' foi salvo com sucesso essa 'action' redirecionará para "http://localhost:3000/articles/#{@article.id}"
    else
      render :new, status: :unprocessable_entity #Se o 'article' não foi salvo, a 'action' reexibe o formulário renderizando 'app/views/articles/new.html.erb' com o código de status '422 unprocessable Entity'. O título e o corpo aqui são valores fictícios.
    end
  end
  #Os dados de 'formulário' enviados são colocados no hash de parâmetros, juntamente com os parâmetros de rota capturados. Assim, a ação 'create' pode acessar o 'title' enviado por meio de 'params[:article][:title]' e o 'body' enviado por meio de 'params[:article][:body]'. Poderíamos passar esses valores individualmente para 'Articles.new, mas isso seria detalhado e possivelmente sujeito a erros. E ficaria pior à medida que adicionássemos mais campos.
  #Passaremos um único Hash que contém os valores. No entanto, ainda devemos especificar quais valores são permitidos nesse Hash. Caso contrário, um usuário mal intencionado poderia enviar campos de formulário extras e sobrescrever dados privados. De fato, se passarmos o Hash 'params[:article]' não filtrado diretamente pára 'Article.new, o Rails gerará um ForbiddenAttributesError para nos alertar sobre o problema. Portanto, usaremos um recurso do Rails chamado 'Strong Parameters' para filtrar os parâmetros. Pense nisso como digitação forte para parâmetros:
  private def article_params
    params.require(:article).permit(:title, :body)
  end
end

#Obs: 'redirect_to' fará com que o navegador faça uma nova solicitação, enquanto 'render' renderiza a exibição especificada para a solicitação atual. É importante usar o 'redirect_to' depois de alterar o estado do banco de dados ou do aplicativo. Caso contrário, se o usuário atualizar a página, o navegador fará a mesma solicitação e a mutação será repetida.