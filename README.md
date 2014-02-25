
# Forest fragmentation with graph database

- Forest fragmenttion system with spatial graph database (neo4j).

## Bibliotecas

- Sinatra http://sinatrarb.com/
- Neography https://github.com/maxdemarzi/neography#rest-api
- Leaflet http://leafletjs.com/

## Montando o ambiente no wiondows

- Install java SDK 7
-- http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html
- Install Neo4j 2.0.1
-- http://www.neo4j.org/download
- Install Neo4j spatial package 2.0.1
-- http://dist.neo4j.org/spatial/neo4j-spatial-0.12-neo4j-2.0.1-server-plugin.zip
-- extrair os arquivos do zip dentro da pasta plugins do neo4j e reiniciar o servidor
- Install jRuby 1.7.10
-- http://www.jruby.org/download
- Install neography
-- gem install neography
- Caso tenha problema com o proxy, mudar de http para https:	
-- gem sources -r http://rubygems.org
-- gem sources -r http://rubygems.org/
-- gem sources -a https://rubygems.org/
- Install bundler 
-- gem install bundler

## Como rodar (prompt de comando)
- Entra na pasta do projeto
- bundle install
- rackup

## Arquivos

- app.rb -> Definições dos layers
- public/index.html -> HTML com o Mapa


