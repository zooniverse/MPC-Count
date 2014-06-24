require 'nokogiri'
require 'open-uri'

class MinorPlanetCounter
  def self.all_time_minor_planet_count
    mpc = Nokogiri::HTML(open('http://minorplanetcenter.net/'))
    mpc.css('.insetn .area:nth-child(3)').each do |link|
      return link.content.gsub("\n","").gsub(/\s+/, "").split(":").last
    end
  end
end
