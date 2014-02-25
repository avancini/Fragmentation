## Arquivo de leitura de CSV
## Cria um banco de dados de espécies e registros a partir do arquivo CSV
## Cria um vetor de hash (id / familia/ nome)

#encoding: utf-8
require 'csv'
require 'rubygems'
require 'neography'

especies = []

CSV.foreach('C:\GitHub\Fragmentation\data\taxonomic_information.csv', :col_sep => ";", :headers => true) do |row|
	especies.push( Hash[row.headers.zip(row.fields)])
end
# escreve apenas o nome da espécie do primeiro valor do vetor
# puts especies[0]["nome"]

## Cria a estrutura taxonômica dentro do banco
@neo = Neography::Rest.new
@neo.create_node
#@neo.create_node_index('especie') não consegui associar um índice ao nó  

## Funciona, mas precisa fazer o loop para inserir todos os pontos
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
	x = @neo.create_node("codigo" => especies[b]["id"], "especie" => especies[b]["nome"])
	@neo.add_label(x, "Especie")
	@neo.create_relationship("familia", x, y)
end



## Fazer query com o cypher
#resultado = neo.execute_query("start n = node:diogo({location}) return n",
#    {:location => "withinDistance:[-26.235,-43.6297,10.0]"})



# @neo.create_relationship("friends", node1, node2)
# @neo.create_node_index("ft_users", "fulltext")
# @neo.add_node_to_index("ft_users", "name", "Max Payne", node1)
# @neo.add_label(node, "Person")












