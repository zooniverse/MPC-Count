require 'nokogiri'
require 'celluloid-http'

class MinorPlanetCounter
  def self.all_time_minor_planet_count
    mpc = Nokogiri::HTML(html_page)
    mpc.css('#main').each do |link|
      return link.content.gsub("\n","").split("Orbits And Names").last.scan(/\b\d{6}\b/)[0]
    end
  end

  def self.html_page
    Celluloid::Http.get('http://www.minorplanetcenter.net/iau/lists/ArchiveStatistics.html').body
  end
end
