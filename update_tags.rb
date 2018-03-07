require 'taglib'
require 'csv'
require 'pathname'

def update_tag_from_csv(csv_file)
  CSV.foreach(csv_file,headers: true) do |row|
    filename = Pathname.new("#{row['dirname']}").join(row['filename']).to_s
    puts "updating file #{filename}"
    TagLib::MPEG::File.open(filename) do |mp3|
      tag = mp3.id3v2_tag
      tag.title = row['title'] unless tag.title == row['title']
      tag.artist = row['artist'] unless tag.artist == row['artist']
      tag.album = row['album'] unless tag.album == row['album']
      album_artist_tag = tag.frame_list('TPE2').first
      if album_artist_tag.nil?
        album_artist_tag = TagLib::ID3v2::TextIdentificationFrame.new("TPE2", TagLib::String::UTF8)
        album_artist_tag.text = row['album artist']
        tag.add_frame(album_artist_tag)
      else
        album_artist_tag.text = row['album artist'] unless album_artist_tag == row['album artist']
      end
      tag.genre = row['genre'] unless tag.genre == row['genre']
      tag.track = row['track'].to_i unless tag.track == row['track'].to_i
      tag.year = row['year'].to_i unless tag.year == row['year'].to_i
      mp3.save
    end
  end
end

if __FILE__ == $0
  if ARGV.empty?
    echo "Please specify CSV file name as argument"
    exit 8
  end
  puts update_tag_from_csv(ARGV[0])
end