require 'nokogiri'
require 'celluloid-http'

class MinorPlanetCounter
  def self.all_time_minor_planet_count
    mpc = Nokogiri::HTML(html_page)
    mpc.css('.insetn .area:nth-child(3)').each do |link|
      return link.content.gsub("\n","").gsub(/\s+/, "").split(":").last
    end
  end

  def self.html_page
    Celluloid::Http.get('http://minorplanetcenter.net/').body
  end
end
