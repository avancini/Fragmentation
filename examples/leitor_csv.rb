## Arquivo de leitura de CSV
## Cria um vetor de hash (id / familia/ nome)

#encoding: utf-8
require 'csv'

especies = []

CSV.foreach('C:\... .csv', :col_sep => ";", :headers => true) do |row|
	especies.push( Hash[row.headers.zip(row.fields)])
end

# escreve o vetor inteiro
puts especies

# escreve apenas primeiro valor do vetor
puts especies[0]["nome"]

# escreve apenas o nome da espécie do primeiro valor do vetor
puts especies[0]["nome"]






