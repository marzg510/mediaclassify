require 'taglib'
require './list_mp3.rb'
require './show_tag.rb'

def set_album_artist_by_artist(path,artist_pattern,album_artist)
  list_mp3_by_artist(path, artist_pattern).each do |f|
    p "processing #{f}"
    TagLib::MPEG::File.open(f) do |mp3|
      tag = mp3.id3v2_tag
      album_artist_tag = tag.frame_list('TPE2').first
#      p "album_artist_tag=#{album_artist_tag}"
      if album_artist_tag.nil?
        album_artist_tag = TagLib::ID3v2::TextIdentificationFrame.new("TPE2", TagLib::String::UTF8)
        album_artist_tag.text = album_artist
        tag.add_frame(album_artist_tag)
#        p "add tag"
        mp3.save
      else
        unless album_artist_tag.to_s == album_artist
          album_artist_tag.text = album_artist
          mp3.save
#          p "set tag"
#        else 
#          p "do nothing"
        end
      end
    end
  end
end

def list_mp3_hiromi_go(path)
  list_mp3_by_artist(path, '郷\s*ひろみ')
end

if __FILE__ == $0
  set_album_artist_by_artist('/home/masaru/Music/classifing/*.mp3','郷\s*ひろみ','郷ひろみ')
#  list_mp3_hiromi_go('/home/masaru/Music/classifing/*.mp3').each do |f|
#    p show_tag(f)
#  end
end

