require 'rubygems'
require 'neography'

@neo = Neography::Rest.new

## Calculate the distance between two coordinates using haversine method
## http://www.markhneedham.com/blog/2013/06/30/ruby-calculating-the-orthodromic-distance-using-the-haversine-formula/
def haversine(lat1, long1, lat2, long2)  
  radius_of_earth = 6378.14 
  rlat1, rlong1, rlat2, rlong2 = [lat1, long1, lat2, long2].map { |d| as_radians(d)}
 
  dlon = rlong1 - rlong2
  dlat = rlat1 - rlat2
 
  a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
  great_circle_distance = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
  radius_of_earth * great_circle_distance
end
 
def as_radians(degrees)
  degrees * Math::PI/180
end
 
def power(num, pow)
  num ** pow
end



## Loop para medir a distância entre todos os pontos de uma mesma espécie e colocar o valor como atributo
# Consulta para gerar a lista de códigos das espécies
species_list = @neo.execute_query("MATCH (a:Especie) RETURN DISTINCT a.id;")

# Loop para percorrer todas as espécies
y = species_list["data"].count - 1
for x in (0..y) 

	id = species_list["data"][x][0]
	#puts "----------#{id}----------"
	
	## Loop para percorrer todas as ocorrências de uma espécie e calcular a distância
	occurrence_list = @neo.execute_query("MATCH (n:Ocorrencia{id:'#{id}'}) return n.codigo, n.lon, n.lat;")
	y2 = occurrence_list["data"].count - 1
	if y2 > 0
		for x1 in (0..y2) 	
	#puts "-------#{occurrence_list["data"][x1][0]}"

			if x1 < y2
				x3 = x1 + 1
				## Loop para calcular a distância entre todos os registros um a um
				for x2 in (x3..y2)
					if defined? occurrence_list["data"][x2][0]
					#puts "Registros ( #{occurrence_list["data"][x1][0]} ) -- ( #{occurrence_list["data"][x2][0]} )" 
					distancia = haversine(occurrence_list["data"][x1][2], occurrence_list["data"][x1][1], occurrence_list["data"][x2][2], occurrence_list["data"][x2][1])
					resultado = @neo.execute_query("START n=node(*), m=node(*) where n.codigo = '#{occurrence_list["data"][x1][0]}' and m.codigo = '#{occurrence_list["data"][x2][0]}' create (n)-[:POPULATION {distancia:#{distancia}}]->(m);")
					#puts distancia
					#puts "************"
					distancia = 0
					end
				end	
			end
		end
	end
	#puts "------------------------"

end