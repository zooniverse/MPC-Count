require 'angelo'
require 'json'
require 'active_support/core_ext/numeric/time'
require_relative './minor_planet_counter'
require_relative './redis_cache'

class MPCFetcher < Angelo::Base

  def redis_conf
    {url: ENV.fetch('REDISTOGO_URL', 'redis://localhost:6379')}
  end

  def redis
    @redis ||= RedisCache.new(redis_conf)
  end

  def cors_headers 
    headers({'Access-Control-Allow-Origin' => '*'})
  end

  task :mpc_count do |cache|
    cache.fetch_or_update('count', 1.hour) { MinorPlanetCounter.all_time_minor_planet_count }
  end

  get '/count' do
    f = future :mpc_count, redis
    content_type :json
    cors_headers
    { count: f.value }.to_json
  end

  get '/pingdom' do
    content_type 'text/plain'
    cors_headers
    'ok'
  end
end

MPCFetcher.run
