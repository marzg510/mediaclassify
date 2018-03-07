require 'taglib'

TagLib::MPEG::File.open('Aerosmith - Angel.mp3') do |mp3|
  puts mp3.tag.title
  p mp3
  p mp3.tag
  p mp3.tag.artist
  p mp3.id3v2_tag.frame_list('TCON').first.to_s
  p mp3.id3v2_tag.frame_list('TPE1').first.to_s
  p mp3.id3v2_tag.frame_list('TPE2').first.to_s
  puts mp3.tag.track.class
end