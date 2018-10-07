require 'rubygems'
require 'bundler'
require 'active_record'
require 'active_support'
require 'active_support/core_ext'
require 'pp'
require 'json'
require 'nkf'
require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'natto'
require 'trigram'
require 'levenshtein'
require 'jaro_winkler'
require 'pp'
require 'naive_bayes'

class String
  def delete_expect_japanese
    self.gsub(/[^\p{Hiragana}|\p{Katakana}|[一-龠々]|ー]/, '')
  end

  def katakana_to_hiragana
    self.tr('ァ-ン', 'ぁ-ん')
  end

  def delete_numeral
    self.gsub(/\d{1,2}コ|個|食|点|日|グラム|単|数|税|円/, '')
  end

  def delete_surrounded
    self.gsub(/\(.*\)|（.*）|<.*>|【.*】|〈.*〉|\[.*\]/, '')
  end

  def to_zenkaku
    NKF.nkf("-Xw", self)
  end
end

ActiveRecord::Base.establish_connection(
      :adapter  => 'mysql2',
      :charset => 'utf8mb4',
      :encoding => 'utf8mb4',
      :collation => 'utf8mb4_general_ci',
      :database => 'wowma',
      :host     => 'localhost',
      :username => 'root',
      :password => ''
)

#class Novel < ActiveRecord::Base; end
#class Url < ActiveRecord::Base; end
class Good < ActiveRecord::Base; end


=begin
class Master < ActiveRecord::Base
  self.table_name = 'master'
  def to_katakana
    word_list = []
    nm = Natto::MeCab.new
    nm.parse(self[:name]) do |n|
      word_list << n.feature.split(',')[7] if !n.is_eos?
    end
    self.update(katakana: word_list.join)
  end
end

class Categorized < ActiveRecord::Base
  self.table_name = 'categorized'
  def get_one_product(names)
    names.split(/、|,/).each do |name|
      return name.strip if name =~ /イッペイ|いっぺい|一平|ｲｯﾍﾟｲ/
    end
    ""
  end

  def normalize
    separated = get_one_product(self[:original])
    normalize = separated.to_zenkaku.delete_surrounded.delete_numeral.delete_expect_japanese
    self.update(normalize: normalize)
  end
end

class History < ActiveRecord::Base
end

class History2 < ActiveRecord::Base
  self.table_name = 'histories2'
end

class Kanji < ActiveRecord::Base
  self.table_name = 'kanji'
end

class Sample < ActiveRecord::Base
  self.table_name = 'sample'
  def get_one_product(names)
    names.split(/、|,/).each do |name|
      return name.strip if name =~ /イッペイ|いっぺい|一平|ｲｯﾍﾟｲ/
    end
    ""
  end

  def normalize
    separated = get_one_product(self[:original])
    normalize = separated.to_zenkaku.delete_surrounded.delete_numeral.delete_expect_japanese
    self.update(normalize: normalize)
  end
end
=end
