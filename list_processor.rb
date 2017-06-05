require 'nokogiri'
require 'json'

class StadtInstance
  name
  wiki_link
  lat
  lon
  state
  
end

def german_charachter_test() 
  puts "ßöäü ÖÄÜ"
end

def find_stadt_details_on_wikipedia(stadt) 
  wiki_url = stadt.wiki_link()
  open(wiki_url)
end

def process_stadt_liste_aus_file() 
  doc = File.open("stadt_liste.txt") { |io| Nokogiri::HTML(io.read.encode('UTF-8')) }  
  stadt_list = []
  doc.xpath('//li').each { |elem| 
    stadt_list << elem.text()
  }
  
  staat_stadt_map = {}
  stadt_list.each { |stadt| 
    stadt_und_staat = stadt.split('(')
    staat = stadt_und_staat[1].gsub(')', '')
    if !staat_stadt_map.has_key? staat
      staat_stadt_map[staat] = []
    end
    staat_stadt_map[staat] << stadt_und_staat[0]
  }
  
  puts JSON.pretty_generate(staat_stadt_map)
end


process_stadt_liste_aus_file()