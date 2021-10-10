# ServeRest HTTParty RSpec

Olá, seja bem-vindo!! Esse é um projeto estudos de testes de API em Ruby com HTTParty e RSpec para o simulador de loja virtual ServeRest API. Para acessar a documentação do ServeRest basta acessar https://serverest.dev/

## Pré-requisitos

Para executar esse projeto é necessário:

- git
- Ruby

## Instalação das dependências de desenvolvimento

Uma vez que todas as dependências já estão listadas no arquivo `Gemfile`, basta executar o comando `bundle install` na raiz do projeto.

## Execução do projeto

`rspec` - executa todos os testes;

`rubocop` - executa a análise estática de código do RuboCop e lista as ofensas;

`rubocop -A` - executa a análisa estática de código do RuboCop e corrige as inconsistências.

## Arquitetura e design pattern

Nesse projeto foi utilizado um pattern muito comum em testes de API. A estrutura do projeto é a seguinte:

`test` - arquivos de teste (separados em subpastas que representam os endpoints);

`requests` - classes com os métodos de request. Todas as classes herdam a `base_class`, onde é importado o HTTParty e declarada a `base_uri`;

`fixtures/schemas` - arquivos de schema utilizados nos testes de schema JSON;

`fixtures/payloads` - arquivos JSON de payload utilizados nos testes;

`support/global_instances` - métodos que instanciam as classes de requests.

## Integração contínua

Foi implementado o pipeline de integração contínua com GitHub Actions. O arquivo de configuração do CI é o `.github/workflows/ci.yml`. Em todo push ou pull_request no branch `master` o pipeline é executado. Da forma como foi configurado, o job `rubocop` é executado como pré-condição dos testes e, caso execute sem falhas, todos os jobs de teste são executados de forma paralela. Cada job de teste executa um arquivo de teste do projeto (`*_spec.rb`)

Sobre os jobs:

`rubocop` - executa a ferramenta de análise estática de código RuboCop. Caso alguma ofensa seja encontrada, o build quebra e já retorna erro;

`post-products-tests` - executa o script `bundle exec rspec spec/test/products/post_products_spec.rb`. Essa mesma lógica se aplica para todos os outros arquivos de teste.

___

Se você tem alguma dúvida ou sugestão, entre em contato! Vamos bater um papo ☕

Feito com 💜 por Bruno Quintanilha.
