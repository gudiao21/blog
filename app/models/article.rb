class Article < ApplicationRecord
    #Como vimos, a criação de um 'resource' é um processo de várias etapas. A manipulação de entrada inválida do usuário é outra etapa desse processo.O 'Rails' fornece um recurso chamado "validations' para nos ajudar a lidar com entradas de usuários inválidas. As 'validations' são regras que são verificadas antes que um objeto de 'model' seja salvo. Se qualquer uma das verificações falhar, o salvamento será interrompido e as mensagens de erro apropriadas serão adicionadas ao atributo errors do objeto modelo."
    #Vamos adicionar algumas validações ao nosso 'model' em 'app/models/article.rb'
    validates :title, presence: true #Essa primeira validação declara que um valor de 'title' deve estar presente. Como o título é uma string, isso significa que o valor do 'title' deve conter pelo menos um caractere qu não seja um espaço em branco.
    validates :body, presence: true, length: { minimum: 10 } #Essa segunda validação declara que um valor de 'body' também deve estar presente. Além disso, ele declara que o valor do 'body' deve ter pelo menos 10 caracteres.
    #Obs: Você pode estar se perguntando onde os atributos de título e corpo são definidos. O 'Active Record' define automaticamente os atributos do modelo para cada coluna da tabela, portanto, você não precisa declarar esses atributos em seu arquivo de 'model'.
end
