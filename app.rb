
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' 
require 'neography'
require 'json'

@neo = Neography::Rest.new

get '/' do
    redirect '/index.html'
end

get '/pontos' do
    #pontos = @neo.execute_query("")

    pontos = [
        {
            :type=>"Feature",
            :geometry=> {
                :type=>"Point",
                :coordinates=>[-47.0,-30.0]
            }
        }
    ]

    content_type :json
    pontos.to_json
end


