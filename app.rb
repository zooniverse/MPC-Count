require 'sinatra'
require 'json'
require 'rack/cors'
require_relative './minor_planet_counter'

APP_ROOT = File.dirname(__FILE__)

class MPCFetcher < Sinatra::Application
  set :root, APP_ROOT

  use Rack::Cors do
    allow do
      origins '*'
      resource '/*', methods: [:get], headers: :all
    end
  end

  get '/count' do
    content_type "application/json"
    {count: MinorPlanetCounter.all_time_minor_planet_count}.to_json
  end

  get '/pingdom' do
    content_type 'text/plain'
    'ok'
  end
end
