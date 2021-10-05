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

`rubocop` - executa a análise estática de código do Rubocop e lista as ofensas;

`rubocop -A` - executa a análisa estática de código e corrige as iconsistências.

## Arquitetura e design pattern

Nesse projeto foi utilizado um pattern muito comum em testes de API. A estrutura do projeto é a seguinte:

`test` - arquivos de teste (separados em subpastas que representam os endpoints);

`requests` - classes com os métodos de request. Todas as classes herdam a `base_class`, onde é importado o HTTParty e declarada a `base_uri`;

`fixtures/schemas` - arquivos de schema utilizados nos testes de schema JSON;

`fixtures/payloads` - arquivos JSON de payload utilizados nos testes;

`support/global_instances` - métodos que instanciam as classes de requests.

___

Se você tem alguma dúvida ou sugestão, entre em contato! Vamos bater um papo ☕
Feito com <3 por Bruno Quintanilha.