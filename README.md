# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

文字列データを一平ちゃんヤキソバ・一平ちゃんラーメン・それ以外に分類します

### How do I get set up? ###

###辞書の作成
categorize_crwalerで以下のコマンドを叩く
~~~
/usr/local/Cellar/mecab/0.996/libexec/mecab/mecab-dict-index -d /usr/local/lib/mecab/dic/ipadic/ -u data/user_dic.dic -f utf-8 -t utf-8 data/add_dic.csv
~~~
###辞書の追加
/usr/local/etc/mecabrcに、以下の文を追加
~~~
userdic = /Users/.../user_dic.dic
~~~
###実行
レーベンシュタイン・バイグラムは
~~~
bundle exec ruby categorize_run.rb オプション
~~~
で実行
オプションは、-helpで参照

ベイズ分析は
~~~
bundle exec ruby machine_learning.rb
~~~
で実行
