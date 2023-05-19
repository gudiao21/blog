class ArticlesController < ApplicationController
 
  def index
    @articles = Article.all
  end

  #Por padrão, a Action 'show' renderizará 'app/views/articles/show.html.erb':
  def show
    #'params[:id]' tem que ter sido mencionado em 'routes.rb', em: get"/articles/:id", to: "articles#show"
    #A Action 'show' chama 'Article.find' com o 'id' capturado pelo parâmetro de rota. O 'article' retonado é armazenado na variável de instância '@article', portanto, é acessível pela visualização. Por padrão, a action 'show renderizará 'app/views/articles/show.html.erb'.
    @article = Article.find(params[:id])

    #Esse condicional abaixo foi recomendado pelo 'chatGPT', pois estava dando erro 'ActiveRecord: :RecordNotFound (Couldn't find Article with 'id'=2):
    if @article.nil?
      flahs[:error] = "Article not found"
      redirect_to articles_path
    else
      @articles = Article.where.not(id: @article.id)
    end
  end
  
  #Agora passamos para o 'C'(Create) do CRUD. Normalmente, em aplicativos da Web, a criação de um novo recurso é um processo de várias etapas. Primeiro, o usuário solicita um formulário para preencher. Em seguida, o usuário envia o formulário. Se não houver erros, o recurso será criado e algum tipo de confirmação será exibida. Caso contrário, o formulário é reexibido com mensagen de erro e o processo é repetido.
  #Em um aplicativ oRails, essas etapas são tratadas convencionalmente pelas ações 'new' e 'create' de um controlador. Vamos adicionar uma implementação típica dessas ações em 'app/controllers/articles_controller.rb, abaixo da ação 'show':
  #Quando visitamos 'http://3000/articles/new, a solicitação 'get /articles/new é mapeada para a nova 'action'. A nova 'action' não tenta salvar '@article'. Portanto, as validações não são verificadas e não haverá ensagens de erro.
  #Quando enviamos o formulário, a solicitação 'POST /articles' é mapeada para a 'action' 'create'. A ação de criação tenta salvar '@article'. Portanto, as 'validations' são verificadas. Se alguma validação falhar, '@article' não será salvo e 'app/views/articles/new.html.erb' será renderizado com mensgens de erro.
  def new #Por padrão essa action 'new' vai renderizar:'app/views/articles/new.html.erb'
    @article = Article.new
  end

  def create
    #@article = Article.new(title: "...", body: "...")
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article #Se o 'article' foi salvo com sucesso essa 'action' redirecionará para "http://localhost:3000/articles/#{@article.id}"
    else
      render :new, status: :unprocessable_entity #Se o 'article' não foi salvo, a 'action' reexibe o formulário renderizando 'app/views/articles/new.html.erb' com o código de status '422 unprocessable Entity'. O título e o corpo aqui são valores fictícios.
    end
  end
  
  #O "update" de um 'resource' é muito semehante à criação de um recurso. Ambos são processos de várias etapas. Primeiro, o usuário solicita um formulário para editar os dados. Em seguida, o usuário envia o formulário. Se não houver erros, o 'resource' será atualizado. Caso contrário, o formulário é reexibido com mensagens de erro e o processo é repetido.
  #Essas etapas são tratadas convencionalmente pelas 'actions' de 'edit' e 'update' de um controlador. Vamos adicionar uma implementação típica dessas 'actions' a 'app/controllers/articles_controller.rb'
  #Note que as 'actions' 'edit' e 'update' se assemelham às 'actions' 'new' e 'create'.
  #A 'action' de 'edit' busca o 'article' do banco de dados e o armazena em '@article' para que possa ser usado ao criar o formulário. Por padrão, a 'action' de 'edit' renderizará 'app/views/articles/edit.html.erb'.
  #A 'action' de 'update' (re)busca o artigo do banco de dados e tenta atualizá-lo com os dados do formulário enviado filtrado por 'article_params'. Se nenhuma 'validation' falha e o 'update' for bem-sucedido, a 'action redireciona o navegador para a página do 'article'. Caso contrário, a 'action' reexibe o formulário com mensagens de erro, renderizando assim 'app/views/articles/edit.html.erb'.

  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #Exluir um recurso é um processo mais simples do que criá-lo(create) ou atualizá-lo(update). Requer apenas uma rota(route) e uma 'action' do controlador. E nosso roteamento engenhoso ('resourceful routing', através de 'resources :articles) já fornece a rota, que mapeia as solicitações 'DELETE /articles/:id' para a action 'destroy' de ArticlesController.
  #Então, vamos adicionar uma action de 'destroy' típica a 'app/controllers/articles_controller.rb', abaixo da action de 'update':

  def destroy
    @article = Article.find(params[:id]) #A 'action' 'destroy' busca um 'article' no banco de dados e chama o 'destroy' nele.
    @article.destroy #Em seguida, ele redireciona o navegador para o caminho raiz com o código de status 303 See Other.
    redirect_to root_path, status: :see_other #Optamos por redirecionar para o caminho raiz porque esse é o nosso principal ponto de acesso para 'articles'. Mas, em outras circunstâncias, você pode optar por redirecionar para, por exemplo, 'articles_path'.
  end


  #---------------------------------------------------------------------------------------------------
  #Os dados de 'formulário' enviados são colocados no hash de parâmetros, juntamente com os parâmetros de rota capturados. Assim, a ação 'create' pode acessar o 'title' enviado por meio de 'params[:article][:title]' e o 'body' enviado por meio de 'params[:article][:body]'. Poderíamos passar esses valores individualmente para 'Articles.new, mas isso seria detalhado e possivelmente sujeito a erros. E ficaria pior à medida que adicionássemos mais campos.
  #Passaremos um único Hash que contém os valores. No entanto, ainda devemos especificar quais valores são permitidos nesse Hash. Caso contrário, um usuário mal intencionado poderia enviar campos de formulário extras e sobrescrever dados privados. De fato, se passarmos o Hash 'params[:article]' não filtrado diretamente pára 'Article.new, o Rails gerará um ForbiddenAttributesError para nos alertar sobre o problema. Portanto, usaremos um recurso do Rails chamado 'Strong Parameters' para filtrar os parâmetros. Pense nisso como digitação forte para parâmetros:
    private
      def article_params
        params.require(:article).permit(:title, :body)
      end
end

#Obs: 'redirect_to' fará com que o navegador faça uma nova solicitação, enquanto 'render' renderiza a exibição especificada para a solicitação atual. É importante usar o 'redirect_to' depois de alterar o estado do banco de dados ou do aplicativo. Caso contrário, se o usuário atualizar a página, o navegador fará a mesma solicitação e a mutação será repetida.