require 'taglib'
require 'csv'
require 'pathname'
require './listtags.rb'

list = list_tags

csv_string = CSV.generate do |csv|
  header = CSV.parse_line(list.lines[0]) 
  header << "collect dir"
  header << "collect file"
  header << "chk status"
  csv << header
  CSV.parse(list,headers: true) do |row|
    chk_status = []
    album_artist = row['album artist']
    artist = album_artist.size==0 ? row['artist'] : album_artist
  #  p artist
    album = row['album']
    title = row['title']
    track = row['track']
    chk_status << 'NoArtist' if artist.nil? || artist.empty?
    chk_status << 'NoAlbum' if album.nil? || album.empty?
    chk_status << 'NoTitle' if title.nil? || title.empty?
    chk_status << 'NoGenre' if row['genre'].nil? || row['genre'].empty?
    chk_status << 'NoTrack' if !(album.nil? || album.empty?) && (track.nil? || track=="0")
#    chk_status << 'NoYear' if row['year'].nil? || row['year']=="0"
    chk_status << 'NoAlbumArtist' if album_artist.empty?
    correct_dir = Pathname.new(artist||'UnknownArtist').join(album||'UnknownAlbum').to_s
    chk_status << 'WrongDir' unless row['dirname'] =~ /#{Regexp.escape(correct_dir)}$/
    correct_file = "#{(track.empty? || track=="0") ? '' : sprintf('%02d_',track)}#{title||'UnknownTitle'}.mp3"
    chk_status << 'WrongFile' unless row['filename'] == correct_file

    chk_status << 'OK' if chk_status.empty?
    row << correct_dir
    row << correct_file
    row << chk_status.join('/')
    csv << row
  end
end
puts csv_string
