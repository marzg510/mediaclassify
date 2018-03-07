require 'taglib'
require 'csv'
require './show_tag.rb'

def list_tags
  csv_string = CSV.generate do |csv|
#    csv << ['dirname','filename','title','artist','album','album artist','genre','track','year']
    csv << HEADER
    Dir.glob('/home/masaru/Music/not_classified_yet/*.mp3').each_with_index do |file,i|
      csv << array_tag(file)
    end
  end
  csv_string
end

if __FILE__ == $0
  puts list_tags
end
