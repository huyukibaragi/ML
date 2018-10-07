require_relative 'common'
# テキストを単語の配列にする
def split_word(text)
  natto = Natto::MeCab.new
  word_arr = Array.new
  natto.parse(text) do |parsed_word|
    # 名詞のみ抽出
    word_arr << parsed_word.surface if parsed_word.feature.split(',')[0] == "名詞"
  end
  word_arr
end

bayes = NaiveBayes.new(:sf, :fantasy)
Novel.where(genre:'SF').each do |sf|# sfカテゴリの学習
  word_array = split_word(sf[:content])
  bayes.train(:sf, *word_array)
end

Novel.where(genre:'fantasy').each do |fantasy|# fantasyカテゴリの学習
  word_array = split_word(fantasy[:content])
  bayes.train(:fantasy, *word_array)
end

bayes.db_filepath = './data/train_data.rb'# 学習データを保存
bayes.save


naive = NaiveBayes.load('./data/train_data.rb')#実際の判定
#的中率を出力
Novel.all.each do |sample|
  sleep 1
  pp sample.novel_title
  test_data = split_word(sample[:content])
  result = naive.classify(*test_data)
  pp result
end
