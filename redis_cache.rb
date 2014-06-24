require 'redis'
require 'celluloid/redis'

class RedisCache
  attr_reader :conn

  def initialize(opts={})
    if opts.has_key? :url
      @conn = Redis.new(url: opts[:url], driver: :celluloid)
    elsif opts.has_key?(:host)&& opts.has_key?(:port)
      @conn = Redis.new(host: opts[:host], port: opts[:port], driver: :celluloid)
    else
      @conn = Redis.new(driver: :celluloid)
    end
  end

  def fetch_or_update(key, ttl, &block)
    resp = @conn.get(key)
    p resp
    return resp unless resp.nil?
    value = block.call
    p key, value, ttl
    @conn.set(key, value)
    @conn.expire(key, ttl.to_i)
    return value
  end
end
