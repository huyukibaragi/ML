require_relative 'common'


page_num = 1
urls = Url.where(genre:'ファンタジー')
urls.each do |url|
  #base_url = url.url
  #comp_url = base_url + page_num.to_s + '/'
  comp_url = url.url
  pp comp_url
  html = open(comp_url) do |f|; f.read end
  sleep 1# マナーはしっかりスリープ1秒
  doc = Nokogiri::HTML.parse(html, charset = 'UTF-8')
  row = {}
  row[:genre] = 'fantasy'
  #row[:novel_title] = doc.css('#container > div.contents1 > a.margin_r20').text
  row[:novel_title] = doc.css('#novel_color > p').text
  #row[:episode_title] = doc.css('#novel_color > p').text
  #row[:content] = doc.css('#novel_honbun').text
  row[:content] = doc.css('#novel_ex').text
  Novel.create(row)
end

=begin
page_num = 1
urls = Url.where(genre:'SF')
urls.each do |url|
  base_url = url.url
  loop do
    comp_url = base_url + page_num.to_s + '/'
    pp comp_url
    html = open(comp_url) do |f|; f.read end
    sleep 1# マナーはしっかりスリープ1秒
    doc = Nokogiri::HTML.parse(html, charset = 'UTF-8')
    break if doc.css('#contents_main > div > span').text == 'エラーが発生しました。'
    row = {}
    row[:genre] = 'SF'
    row[:novel_title] = doc.css('#container > div.contents1 > a.margin_r20').text
    row[:episode_title] = doc.css('#novel_color > p').text
    row[:content] = doc.css('#novel_honbun').text
    Novel.create(row)
    page_num = page_num + 1
  end
end
=end

=begin
base_url = 'http://yomou.syosetu.com/search.php?&order=favnovelcnt&notnizi=1&genre=201-202&p='

page_num = 1
loop do
  comp_url = base_url + page_num.to_s
  html = open(comp_url) do |f|; f.read end
  sleep 1# マナーはしっかりスリープ1秒
  doc = Nokogiri::HTML.parse(html, charset = 'UTF-8')
  doc.css('div.novel_h').each do |novel|
    pp 
    row = {}
    row[:genre] = 'ファンタジー'
    row[:novel_title] = novel.text
    row[:url] = novel.css('a')[0][:href]
    Url.create(row)
  end
  page_num += 1
end
=end
