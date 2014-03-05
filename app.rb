
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' 
require 'neography'
require 'json'


neo = Neography::Rest.new




get '/' do
    redirect '/index.html'
end

get '/pontos' do
     #resultado = neo.execute_query("start n = node:occurrence({location}) where n.id = '101535' return n;")
     num=params[:numero]
     resultado = neo.execute_query("match (n:Ocorrencia{id:'#{num}'}) return n.id, n.lon, n.lat;")
     
#puts resultado
    pontos = []

        y = resultado["data"].count - 1

        for x in (0..y) 
            valor = resultado["data"][x]
            puts valor[2]
                pontos[x]={
                    :type=>"Feature",
                    :geometry=> {
                        :type=>"Point",
                        :coordinates=>[valor[1],valor[2]]
                    }
                }
        
        end

    

    content_type :json
    pontos.to_json
end


