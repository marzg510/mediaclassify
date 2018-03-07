require 'taglib'
require 'pathname'
require 'fileutils'
require './list_mp3.rb'

def classify_mp3(path)
  Dir.glob(path).each_with_index do |f,i|
    artist,album,title,track,disc = TagLib::MPEG::File.open(f) do |mp3|
      artist = mp3.id3v2_tag.frame_list('TPE2').first.to_s || mp3.tag.artist || 'UNKNOWN ARTIST'
      album = mp3.tag.album || 'UNKNOWN ALBUM'
      track = mp3.tag.track
      title = mp3.tag.title
      disc = mp3.id3v2_tag.frame_list('TPOS').first.to_s
      break artist,album,title,track,disc
    end
    next if artist.nil? || album.nil?
#    puts "#{f} #{artist} #{album}"
    # ディレクトリ決定
    dir = Pathname.new('/home/masaru/Music/classifing/').join(artist).join(album)
    # ファイル名決定
    disc_no,disc_max = disc.split('/')
    disc_pre = disc_max.to_i > 1 ? "#{disc_no}-" : ''
    newname = "#{disc_pre}#{track}_#{title}.mp3"
    newpath = Pathname.new(dir).join(newname)
    puts "classify #{dir}/#{newname}"
    # ディレクトリ作成
    FileUtils.mkdir_p(dir)
    # ファイル移動
    File.rename(f,newpath) unless f == newpath
#    break
  end
end

def classify_mp3_hiromi_go(path)
  classify_mp3(path)
end

if __FILE__ == $0
  classify_mp3_hiromi_go('/home/masaru/Music/classifing/**/*.mp3')
end
