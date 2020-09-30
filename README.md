# QTáRolando?

Este é um app desenvolvido, em Flutter e Dart, para o projeto de Extensão Apps4Society do Campus IV - UFPB, em Rio Tinto, cujo o objetivo é oferecer, de forma simples e fácil, tanto a visualização quanto as informações de eventos, inicialmente com o foco aos relacionados a UFPB, no estado da Paraíba.

#### QTáRolando? Screenshots

<table>
  <tr>
    <td>Homepage</td>
    <td>Search</td>
    <td>Filter</td>
  </tr>
  <tr>
    <td><img src="screenshots/Homepage-Light.png" width=270 height=540></td>
    <td><img src="screenshots/Search.png" width=270 height=540></td>
    <td><img src="screenshots/Filter.png" width=270 height=540></td>
  </tr>
  <tr>
    <td>Share</td>
    <td>Event Details</td>
    <td>Dark Theme</td>
  </tr>
  <tr>
    <td><img src="screenshots/Share.png" width=270 height=540></td>
    <td><img src="screenshots/Event-Details.png" width=270 height=540></td>
    <td><img src="screenshots/HomePage-Dark.png" width=270 height=540></td>
  </tr>
 </table>

## Pré Requisitos
### Flutter v1.17.5 ou superior
Como iniciar com o Flutter: https://flutter.dev/docs/get-started/install
### Hasura Engine
Como iniciar com o Docker: [https://hasura.io/docs/1.0/graphql/manual/getting-started/docker-simple.html#docker-simple](https://hasura.io/docs/1.0/graphql/manual/getting-started/docker-simple.html#docker-simple)

Como iniciar com o Heroku: [https://hasura.io/docs/cloud/1.0/manual/getting-started/index.html](https://hasura.io/docs/cloud/1.0/manual/getting-started/index.html)

O **Hasura**, em seu arquivo docker-compose, ao se iniciar com o Docker, exige o **PostgreSQL** em sua versão 12 e utiliza uma imagem do **GraphQL**, do próprio Hasura, em sua versão 1.3.0.

### Plugins/Extensões
Embora os plugins, que serão listados abaixo, não sejam necessários para a execução do projeto, auxiliam muito na produtividade durante o desenvolvimento do mesmo.

OBS: Tanto os plugins quanto o projeto podem ser encontrados/desenvolvido no Android Studio ou no Visual Studio Code.

#### Dart
O Dart  fornece ao VS Code ou Android Studio, suporte para a linguagem de programação Dart e  ferramentas para editar, refatorar, executar e recarregar aplicativos móveis Flutter e aplicativos web AngularDart com eficácia.
#### Flutter
Esta extensão do VS Code ou Android Studio adiciona suporte para edição, refatoração, execução e recarga de aplicativos móveis Flutter de maneira eficaz, bem como suporte para a linguagem de programação Dart.

## Iniciando o Projeto
Após baixar/clonar o projeto abra a pasta do projeto em seu ambiente de desenvolvimento (Android Studio ou no Visual Studio Code), no console ou terminal do ambiente execute os seguintes comandos:

### Comando para baixar todas as dependências do projeto:
```{sh}
flutter pub get
```
### Após o comando terminar, como um dispositivo conectado ou emulador aberto, execute o seguinte comando:
```{sh}
flutter run
```
Pronto o projeto já estará executando, e pronto para o desenvolvimento.
