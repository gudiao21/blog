#através do comando 'rails generate model comment commenter:string body:text article:references' gerará 4 arquivos:
#1)'db/migrate/timestamp_create_comments.rb'- 'Migration' para criar a tabela de 'comments' em seu banco de dados.
#2)'app/models/comment.rb'- Cria o 'model' 'comment'.
#3)'test/models/comment_test.rb'- Teste de aprovação para o 'model' 'comment'.
#4)'test/fixtures/comments.yml' - Amostra de 'comments' para uso em testes.

# ':references' encontrado no comando 'rails generate model comment commenter:string body:text article:references' é um tipo de dados especial para Models. Ele cria uma nova coluna em sua tabela de banco de dados com o nome do modelo fornecido anexado com um '_id' que pode conter valores inteiros. Para entender melhor, analise o arquivo 'db/schema.rb' após executar a 'migration' atraveś do comando 'rails db:migrate'. O Rails é inteligente o suficiente para apenas axecutar as 'migrations' que ainda não forma executadas no banco de dados atual, portanto, neste caso, você verá apenas a criação de 'comments', pois 'articles' já foi criado.
class Comment < ApplicationRecord
  belongs_to :article #Declara que cada comentário(comment) pertence a um 'article', ou seja, poderá ter vários comentários para cada 'article'.
end