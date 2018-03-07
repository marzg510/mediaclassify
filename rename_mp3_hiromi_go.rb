require 'taglib'

def rename_file(file)
end

def rename_file_hiromi_go(path)
  cnt = 0
  Dir.glob(path).each_with_index do |filename,i|
    TagLib::MPEG::File.open(filename) do |mp3|
      artist = mp3.tag.artist
      album = mp3.tag.album
      album_artist = mp3.id3v2_tag.frame_list('TPE2').first.to_s
      if artist =~ /郷\s*ひろみ/ then
        puts "#{File.basename(filename)} / #{artist} / #{album} / #{album_artist}"
        cnt += 1
      end
    end
    break if cnt >= 10
  end
end

if __FILE__ == $0
  rename_file_hiromi_go('/home/masaru/Music/not_classified_yet/*.mp3')
end
