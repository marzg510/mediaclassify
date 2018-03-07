require 'taglib'

TagLib::MPEG::File.open('Aerosmith - Angel.mp3') do |mp3|
  puts mp3.tag.title
  p mp3
  p mp3.tag
  p mp3.tag.artist
  p mp3.id3v2_tag.frame_list('TPE2').first.to_s
  mp3.tag.artist = 'Aerosmith'
  mp3.id3v2_tag.frame_list('TPE2').first.text='Aerosmith2'
  mp3.save
end