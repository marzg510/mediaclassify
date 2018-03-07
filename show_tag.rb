require 'taglib'
require 'csv'

HEADER=['dirname','filename','title','artist','album','album artist',
        'genre','track','year','disc#']
def array_tag(filename)
  TagLib::MPEG::File.open(filename) do |mp3|
    [
      File.dirname(filename),File.basename(filename),
      mp3.tag.title,mp3.tag.artist,
      mp3.tag.album,
      mp3.id3v2_tag.frame_list('TPE2').first.to_s,
      mp3.tag.genre,
      mp3.tag.track,
      mp3.tag.year,
      mp3.id3v2_tag.frame_list('TPOS').first.to_s,
    ]
  end
end
def show_tag(filename)
  CSV.generate do |csv|
    csv << array_tag(filename)
  end
end

if __FILE__ == $0
  puts show_tag(ARGV[0])
#  p array_tag(ARGV[0])
end

