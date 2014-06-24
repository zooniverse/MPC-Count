require 'angelo'
require 'json'
require_relative './minor_planet_counter'

class MPCFetcher < Angelo::Base

  def cors_headers 
    headers({'Access-Control-Allow-Origin' => '*'})
  end

  task :mpc_count do
    {count: MinorPlanetCounter.all_time_minor_planet_count}.to_json
  end

  get '/count' do
    f = future :mpc_count
    content_type :json
    cors_headers
    p f.value
    f.value 
  end

  get '/pingdom' do
    content_type 'text/plain'
    cors_headers
    'ok'
  end
end

MPCFetcher.run
