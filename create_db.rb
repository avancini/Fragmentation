## Arquivo de leitura de CSV
## Cria um banco de dados de espécies e registros a partir do arquivo CSV
## Cria um vetor de hash (id / familia/ nome)

#encoding: utf-8
require 'csv'
require 'rubygems'
require 'neography'
require 'fileutils' 

## Comando para deletar um diretório e para recriar o diretório
#FileUtils.rm_rf('C:\Users\Usuário\Documents\Neo4j\default.graphdb')
#FileUtils.mkdir('C:\Users\Usuário\Documents\Neo4j\default.graphdb')

especies = []

CSV.foreach('C:\GitHub\Fragmentation\data\taxonomic_information.csv', :col_sep => ";", :headers => true) do |row|
	especies.push( Hash[row.headers.zip(row.fields)])
end
# escreve apenas o nome da espécie do primeiro valor do vetor
# puts especies[0]["nome"]

## Cria a estrutura taxonômica dentro do banco
@neo = Neography::Rest.new
#@neo.create_node
#@neo.create_node_index('especie') não consegui associar um índice ao nó  

## Loop para varrer as linhas do arquivo .CSV criando um vetor e inserindo no banco as famílias e as espécies criando o link entre elas
a = especies.count - 1

c = especies[0]["familia"]
y = @neo.create_node("familia" => c)
@neo.add_label(y, "Familia")

for b in (0..a)
	if (c != especies[b]["familia"])
		c = especies[b]["familia"]
 		y = @neo.create_node("familia" => c)
		@neo.add_label(y, "Familia")
	end
	x = @neo.create_node(:id => especies[b]["id"], "especie" => especies[b]["nome"])
	@neo.add_label(x, "Especie")
	@neo.create_relationship("TAXON_IN", x, y)
end


@neo.create_spatial_index('occurrence')

ocorrencias = []

CSV.foreach('C:\GitHub\Fragmentation\data\occurrence_information.csv', :col_sep => ";", :headers => true) do |row|
	ocorrencias.push( Hash[row.headers.zip(row.fields)])
end

## Loop para varrer as linhas do arquivo .CSV criando um vetor e inserindo no banco os pontos de ocorrência e criando o link com as espécies
a = ocorrencias.count - 1

for b in (0..a)
	x = @neo.create_node({:id => ocorrencias[b]["id"], :codigo => ocorrencias[b]["codigo"], :lat => ocorrencias[b]["latitude"].to_f, :lon => ocorrencias[b]["longitude"].to_f})
	@neo.add_label(x, "Ocorrencia")
	## Cria o ponto espacialmente usando o index occurrence
	@neo.add_node_to_spatial_index("occurrence", x)
	puts b
end

## Cria o relacionamento entre os registros de ocorrência e as espécies
resultado = @neo.execute_query("MATCH (a:Ocorrencia),(b:Especie) WHERE a.id = b.id CREATE (a)-[r:POINT_IN]->(b);")


## Cria o relacionamento entre os registros de ocorrência de uma mesma espécie com a distância entre os pontos
resultado = @neo.execute_query("MATCH (a:Ocorrencia),(b:Ocorrencia) WHERE NOT (a)-[:POPULATION]->(b) AND a.id = b.id CREATE (a)-[r:POPULATION]->(b);")





## Fazer query com o cypher
#resultado = neo.execute_query("start n = node:diogo({location}) return n",
#    {:location => "withinDistance:[-26.235,-43.6297,10.0]"})



# @neo.create_relationship("friends", node1, node2)
# @neo.create_node_index("ft_users", "fulltext")
# @neo.add_node_to_index("ft_users", "name", "Max Payne", node1)
# @neo.add_label(node, "Person")