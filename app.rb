
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
    #pontos = @neo.execute_query("")
    resultado = neo.execute_query("start n = node:diogo({location}) return n",
    {:location => "withinDistance:[-26.235,-43.6297,10.0]"})

    pontos = []
            
        y = resultado["data"].count - 1

        for x in (0..y) 
            valor = resultado["data"][x][0]["data"]
                pontos[x]={
                    :type=>"Feature",
                    :geometry=> {
                        :type=>"Point",
                        :coordinates=>[valor["lon"],valor["lat"]]
                    }
                }
        
        end

    

    content_type :json
    pontos.to_json
end


