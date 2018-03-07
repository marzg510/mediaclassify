require 'taglib'
require 'fileutils'
require './list_mp3.rb'

def move_to_classifying(filelist)
  filelist.each_with_index do |f,i|
    p "moving #{f}"
    FileUtils.mv(f,'/home/masaru/Music/classifing/')
  end
end

if __FILE__ == $0
  # 移動対象ファイルリストを作成
  list = list_mp3_by_album('/home/masaru/Music/not_classified_yet/','妖怪ウォッチ')
#  p list
  # 移動
  move_to_classifying(list)
end
