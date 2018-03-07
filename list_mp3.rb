require 'taglib'
require 'pathname'
require './show_tag.rb'

def list_mp3_by_album(path, album_pattern)
  cnt = 0
  arr = []
  Dir.glob(Pathname.new(path).join('*.mp3')).each_with_index do |filename,i|
    TagLib::MPEG::File.open(filename) do |mp3|
      album= mp3.tag.album
      if album=~ /#{album_pattern}/ then
        arr << filename
        cnt += 1
      end
    end
#    break if cnt >= 1
  end
  arr
end
def list_mp3_by_artist(path, artist_pattern)
  cnt = 0
  arr = []
  Dir.glob(path).each_with_index do |filename,i|
    TagLib::MPEG::File.open(filename) do |mp3|
      artist = mp3.tag.artist
      if artist =~ /#{artist_pattern}/ then
        arr << filename
        cnt += 1
      end
    end
#    break if cnt >= 1
  end
  arr
end

def list_mp3(path)
  arr = []
  Dir.glob(Pathname.new(path).join('*.mp3')).each_with_index do |filename,i|
    puts filename
    TagLib::MPEG::File.open(filename) do |mp3|
      arr << filename
    end
  end
  arr
end

def list_mp3_hiromi_go(path)
  list_mp3_by_artist(path, '郷\s*ひろみ')
end

if __FILE__ == $0
  if ARGV[0] == ""
    list = list_mp3_hiromi_go('/home/masaru/Music/classifing/*.mp3')
  else
    list = list_mp3(ARGV[1]) if ARGV[0] == "all"
    list = list_mp3_by_album(ARGV[1],ARGV[2]) if ARGV[0] == "album"
  end
  list.each do |f|
    p show_tag(f)
  end
end

