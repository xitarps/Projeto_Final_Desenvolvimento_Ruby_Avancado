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

Após clonar o repositório, em um terminal execute:<br>

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

Acessar o endereço no browser:<br>
http://localhost:3000

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

## Detalhamento do Reporter e DSL


Define campos que terão seus valores carregados para o CSV
```
fields :name, :price
```

Define caminho que salvará o arquivo CSV<br>
*no caso aqui removemos do tmp ao utilizar o activeStorage(app/models/csv_report.rb:22)
```
file_path "#{Rails.root}/tmp/"
```

Define tipo de escrita do CSV<br>
Pode ser trocado para :append, assim não concatena ao inves de apagar o conteudo anterior
```
mode :write
```

Define a presença do cabeçalho no CSV(true/false)
```
write_headers true
```

Define quais os atributos que serão utilizados no cabeçalho do CSV
```
headers :name, :price
```

Define qual o separador utilizado no CSV<br>
*ex: excel teve bons resultados com ';'
```
column_separator ","
```