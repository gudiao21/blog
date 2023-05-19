#através do comando 'rails generate model comment commenter:string body:text article:references' gerará 4 arquivos:
#1)'db/migrate/timestamp_create_comments.rb'- 'Migration' para criar a tabela de 'comments' em seu banco de dados.
#2)'app/models/comment.rb'- Cria o 'model' 'comment'.
#3)'test/models/comment_test.rb'- Teste de aprovação para o 'model' 'comment'.
#4)'test/fixtures/comments.yml' - Amostra de 'comments' para uso em testes.

class Comment < ApplicationRecord
  belongs_to :article
end
