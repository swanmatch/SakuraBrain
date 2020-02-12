# Rubyで桜の開花予想をする

**※ひさびさにソース見たら糞汚い**

## 概要

[RubyBrain](https://qiita.com/elgoog/items/8e7102a87889950d060d)([github](https://github.com/elgoog/ruby_brain))を利用して、
気象庁が公開している桜の開花日と最高温度、最低温度、平均気温の日次の推移より、
ニューラルネットワークを構築及び学習し、桜の満開日の予測を行う。

## 使い方

1. 前処理の都合、`rake db:seed`で気象庁が公開しているCSVファイルをデータベースに登録します。
2. `rake brain:learn[3000]`で学習を開始します。  
3000は学習回数です。  
ネットワークモデル自体を変更したい場合、`lib/task/learn_data.rake`内のMODELを任意に変更してください。  
入力層の120*3(1月から4月の最高気温、最低気温、平均気温)と出力層の1(満開日)は変えないでください。
3. 学習が終わったら`rake brain:test[30]`で正答率とズレた平均日数を表示します。
4. 気象庁から適当な地域の気温データを持ってきて作成したモデルに流し込めば、
標本木がない地域でも桜の開花予想を行うことができます。

## 例1

```
$ rake brain:test[30]

1998年 松本　　満開日-正解:04/12 予測:04/14
1988年 名古屋　満開日-正解:04/12 予測:04/12
2007年 厳原　　満開日-正解:04/03 予測:04/06
1993年 新潟　　満開日-正解:04/17 予測:04/15
1993年 江差　　満開日-正解:05/06 予測:05/03
1995年 八丈島　満開日-正解:04/12 予測:04/03
1999年 浜松　　満開日-正解:04/02 予測:04/02
1997年 宮崎　　満開日-正解:04/01 予測:03/29
2005年 敦賀　　満開日-正解:04/11 予測:04/11
2002年 豊岡　　満開日-正解:04/01 予測:03/28
1991年 江差　　満開日-正解:05/06 予測:05/03
1987年 浜田　　満開日-正解:04/08 予測:04/07
2003年 富山　　満開日-正解:04/12 予測:04/09
2015年 鳥取　　満開日-正解:04/02 予測:04/02
2005年 相川　　満開日-正解:04/23 予測:04/20
1982年 奈良　　満開日-正解:04/02 予測:04/01
1983年 種子島　満開日-正解:04/09 予測:03/31
2000年 大島　　満開日-正解:04/11 予測:04/08
2015年 前橋　　満開日-正解:04/02 予測:04/02
2002年 奈良　　満開日-正解:03/27 予測:03/30
2001年 広島　　満開日-正解:04/02 予測:04/02
2005年 高知　　満開日-正解:04/07 予測:04/01
2002年 舞鶴　　満開日-正解:04/01 予測:03/29
2004年 奈良　　満開日-正解:04/01 予測:03/31
1996年 新潟　　満開日-正解:04/24 予測:04/25
2003年 輪島　　満開日-正解:04/13 予測:04/12
2000年 八戸　　満開日-正解:05/02 予測:05/02
1994年 洲本　　満開日-正解:04/07 予測:04/16
1995年 甲府　　満開日-正解:04/08 予測:04/07
1984年 宮崎　　満開日-正解:04/08 予測:04/07

*************************************
満開正解数　： 4/30
満開平均誤差： 2.433333333333333日
*************************************
```

学習データとテストデータを分けていないのであまり信憑性はないです。

## 例2

CSVファイルから桜の開花日を予想する。

```sh
$ rake brain:estimate[matsumoto_fill_avr.csv]
2020/04/16
```

## 考察

日本を代表する桜であるソメイヨシノはすべてDNAが一緒らしく、同じ条件なら開花も同時になるらしい。  
また日本人は桜が大好きなので比較的まじめに開花日や満開日を記録していて、
データがそこそこ揃うのでディープラーニング向きでした。

海に近い地域地域(青森、八丈島、種子島)はニューラルネットの予測より
いずれの年も10日ほど早く桜が咲いているようでした。  
土壌中の塩分濃度なんかも植物の発育に影響あるのかもしれません。

## まとめ

ルールとマナーを守って楽しくお花見しましょう。

