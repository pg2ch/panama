# panama
パナマ文書を便利に扱うツールを作ろう。

## PanaMap
OpenStreetMapに、パナマ文書に記載された謎の住所のマーカーを表示するウェブサービス。

### 開発環境
* MacBook Pro
* Xamarin Studio (Beta)
* Mono 4.4 (Beta)
* PostgreSQL 9.5
ASP.NET Web APIが使えるようになったMono 4.4を使ってみたかったのでXamarinのベータ版を使っている。
LinuxでASP.NETを動かすとファイルシステムが大文字小文字を区別するあたりの調整でイライラすることが判明した。

経度緯度情報はGoogle Geocoding APIなどを使用して取得している。
1日2500リクエスト制限の関係で、まだ日本近辺しか取得できていないため、データはまだ歯抜け状態となっている。
また、パナマ文書は誤記載と思われる住所も多く、とくに日本の住所は修正が必要な場合も多いようだ。
Google Mapsで住所検索してピンポイントでストリートビューが表示されるようならば完璧な住所といえると思う。
支援者求む。

### 実行方法
monoに付属のxsp4を使っている。
mod_monoで動くかは試していないので知らん。
    $ cd panama/PamaMac
    $ xsp4 --verbose --port 80
