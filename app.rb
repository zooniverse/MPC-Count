require 'sinatra'
require 'json'
require_relative './minor_planet_counter'

APP_ROOT = File.dirname(__FILE__)

class MPCFetcher < Sinatra::Application
  set :root, APP_ROOT

  get '/count' do
    content_type "application/json"
    MinorPlanetCounter.all_time_minor_planet_count.to_json
  end

  get '/pingdom' do
    content_type 'text/plain'
    'ok'
  end
end
