# plurk-crawler
Plurk Crawler 是一款由Ruby寫成的程式，能自動備份特定使用者當天的河道內容。

本程式可在Windows, Mac OSX及Linux上運行。

安裝需求
-----------
* Ruby 2.2.3（或以上）
* Ruby Gems 2.5.0（或以上）

以上兩款軟體可從以下網址取得：

Ruby: https://www.ruby-lang.org/zh_tw/downloads/

Ruby Gems: https://rubygems.org/pages/download

安裝方法(所有作業系統通用)
-----------

1.將Plurk Crawler下載到你的電腦中：

https://github.com/dollars0427/plurk-crawler/archive/master.zip

2.解壓縮後打開Terminal(Windows下是cmd)，進入Plurk Crawler所在資料夾：

```bash
$ cd plurk-crawler-master
```

3.執行下列指令：

```bash
$ bundle install
```

設定
-----------

setting.sample.json 是Plurk Crawler的設定檔範本。在開始使用之前，你必須先將其取改為setting.json，並修改裡面的內容。

以下是設定檔的範例：

```json
{
	"consumerKey":"你的consume key",
	"consumerSecert":"你的consume serect",
	"accessKey":"你的access key",
	"accessSecret":"你的access sercet"
}

```
Plurk Crawler必須獲得以上資訊才能正常運作。若然你沒有consumerKey及accessKey，可參考以下網址的教學：

http://zh.blog.plurk.com/archives/1121

運行
-----------

```bash
$ ruby crawler.rb ['使用者名稱']
```

稍侯片刻後，備份內容將會自動儲存於output資料夾內。

版本記錄
-----------
請參考Release頁面。

回報問題
-----------
如在使用上有任何問題，歡迎打開Issues或直接在噗浪上詢問作者： 

www.plurk.com/bluewinds0624