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
end