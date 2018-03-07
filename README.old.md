MP3Classify
==================

## Overview

## installation
```
sudo apt-get install libtag1-dev
gem install taglib-ruby
```

## Usage
1. check
```
# check all
ruby check_tags.rb > check_list_all.csv

# dir/file ng only
ruby check_tags.rb \
| grep -v ",NoAlbumArtist/WrongDir/WrongFile$" \
> check_list_move_candidate.csv

# check ng only
ruby check_tags.rb | grep -v "OK$" | grep -v ",WrongFile$" | grep -v ",WrongDir$" \
| grep -v ",WrongDir/WrongFile$" \
| grep -v ",NoAlbumArtist/WrongDir/WrongFile$" \
> check_list_ng.csv
```
  * show tag
```
ruby show_tag.rb filename
```
2. update tag
* update from csv
```
ruby update_tags.rb album_artist_update_target.csv
```
3. move & rename
```
ruby class_mp3.rb < check_list.csv
```


## developer memo

code page ng
 - 04_Vampire Killer.mp3

### check code page
require 'taglib'
TagLib::MPEG::File.open('/home/masaru/Music/ - 04_Vampire Killer.mp3') do |mp3|
  tag = mp3.id3v2_tag
  talb = tag.frame_list('TALB').first
  p talb.class
  p talb.to_s
  p talb.text_encoding
#  talb.text_encoding=TagLib::String::UTF8
  p talb.to_s.unpack('H*').pop.scan(/[0-9a-f]{2}/).join(",")
end


## links
http://wikiwiki.jp/qmp/?Plugins%2FLibraries%2FTag%20Editors%2FID3%20Tags
http://www.rubydoc.info/github/robinst/taglib-ruby/TagLib/MPEG/File

