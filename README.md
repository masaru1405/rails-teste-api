# README

## Desafio API
Criar um endpoint que faça a leitura de um arquivo .csv, popule o banco de dados com essas informações e com
isso será necessário exibir todos os registros em json.
Requisitos:
- O desafio deve ser desenvolvido utilizando Ruby e tendo o Rails como framework;
- Seguindo o padrão API RESTful;
- Seguir o Rubocop style-guide;
- A leitura do arquivo .csv deve ser através de um endpoint diferente da listagem de títulos;
- Ordenar pelo ano de lançamento;
- Filtrar os registros por ano de lançamento, gênero, país*;
- Garantir que não haja duplicidade de registros;
- O projeto deve ser disponibilizado em um repositório aberto no GitHub. Envie a URL assim que
possível;

## Observação
- Banco de dados utilizado: SQLite.
- O arquivo .csv está localizado em `lib/tasks`.
- A coluna **type** do arquivo .csv estava dando conflito com o sistema, pois é uma palavra reservada. Mudei no próprio arquivo .csv para **show_type**.
- Para importar o arquivo .csv, ler seus dados, deletar o BD, criar o BD e migrar os dados, executar o comando: `rails dev:feed_db`.
- Na resposta de uma requisição, os seguintes atributos mudam de nome para obecer ao padrão requisitado:
  - de **show_type** para **genre**
  - de **date_added** para **published_at**
  - de **release_year** para **year**
- O **id** dos dados na resposta de uma requisição foi gerado pelo próprio Rails.
- Para não permitir a duplicidade dos dados, foi adicionado uma validação no model **NetflixShow**: `validates :title, uniqueness: true`.
- As respostas de retorno estão ordenadas pelo ano (year) em ordem decrescente.
- O atributo **published_at** está no formato `%Y-%d-%m`.