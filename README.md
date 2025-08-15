# Projeto_Final_Desenvolvimento_Ruby_Avancado

Projeto desenvolvido para o
<strong>MBA em Desenvolvimento de Software Avançado com foco em Ruby on Rails</strong>
<br>
https://mbaonrails.com.br

O Sistema consiste em Um scaffold/CRUD de produtos para gerar dados
E um Módulo que inclui DSL/interface amigavel para geração de relatórios CSV

## Autores do projeto
Jean Delamare Pedroni <br>
Linkedin: https://www.linkedin.com/in/jean-delamare-pedroni-90a33372 <br>
Github: https://github.com/jeanpedroni2

Rodrigo Pimentel Sátyro(Xita) <br>
Linkedin: https://www.linkedin.com/in/rodrigopimentelsatyro-xita <br>
Github: https://github.com/xitarps <br>

## Tecnologias
 - Ruby
 - Rails
 - PostgreSQL
 - SolidQueue

## Subindo o projeto

Em um terminal execute:<br>

Configurtando:

```
bundle intall
```

```
rails db:create db:migrate db:seed
```

Subindo aplicação:
```
rails server
```


Subindo o SolidQueue:<br>

Em outro terminal execute:
```
bundle exec rake solid_queue:start
```

## Objetivos do projeto
Implementar:
1. DSL (Domain-Specific Language)
2. Enumerable / Lazy Evaluation
3. Concorrência e Paralelismo
4. Organização e Composição

Arquivos/tecnologias de interesse:
1. lib/csv_reporter/reporter.rb
2. app/models/csv_file_collection.rb
3. SolidQueue
4. Rails(MVC/Job/Commits)
