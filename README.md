# DanmakuCat
東方みたいな弾幕ゲームを作りたい　高専祭用

### こんなのを作りたい
- マウス操作
- ボールに当たったらゲームオーバー(またはHPが減る) ←ボールは当たり判定を計算するのが難しいかもしれないからブロックにするかも
- なるべく長い時間生き延びる(ゲームオーバー時ランキング表示)＜スコア方式にしたいかも
- 簡単にステージを作れるようにしたい(jsonファイルを検討中)
- ただかわすだけだと面白くないから無敵になれるアイテムとかスコアを増えやすくするアイテムとか追加したい
- スコア方式にしてランキングみたいなのを作りたい

## 環境
- windows10
- Processing4
- ~~fpsが60出る環境~~　(設定したfpsに合わせて遅延するように変更したため問題はない←はず)

## 譜面形式
### サンプル
![jsom-sample](https://user-images.githubusercontent.com/85401098/188897515-98d9b22a-f8e1-4151-a291-c4b6be4d8417.PNG)

![Field](https://user-images.githubusercontent.com/85401098/189336777-b695b3b2-d552-4217-9e6a-f9be35423d21.png)


### 形式詳細
#### 設定
- stagename ステージ名(譜面名)
- amount 弾幕数
#### ステージ(譜面)
- x ブロックがスポーンするX座標
- y ブロックがスポーンするY座標
- size ブロックの大きさ
- checktime ブロックがスポーンする場所を知らせるマーカーをスポーンさせる時間（始まってから）単位はms
- poptime ブロックがスポーンする時間(始まってから) 単位はms
- rmtime ブロックが消失する時間(始まってから) 単位はms

## List 書き方
![キャプチャ](https://user-images.githubusercontent.com/85401098/190831453-e48f74b8-2625-4beb-80ca-a28e88fab0f4.PNG)
- listamount 読み込む譜面の数
- name 選曲画面に表示する名前
- path 譜面のjsonファイルがあるパス
- sound 譜面のbgmのパスurlでも可

## その他
- 敵 現状は何もアイデアが浮かばなかったのでなんとなく鷲（鷹）←猫の天敵らしいので(当たり判定つけるか迷い中)
- HP 一発アウトにするつもり HPバーの実装は出来ても邪魔になるかもしれない
- ブロックの移動 検討中 Jsonファイルが大きくなる可能性があるからわからない
- bgm タイフーンパレード　https://dova-s.jp/bgm/play3406.html

## コミット履歴
- b64ab119e2a6ed19229309e88f7d74e0f48fe9ee　　　遅延を設定fpsに応じて遅らせるようにした
- eb4b15357a0d31d9575b19461814a73b05e9cf95　　　画像をassetsフォルダに配置
- 562bc53d44d778426a6db40c2ceb278268f0942c　　　[とある人](https://twitter.com/Ym147J)の助言から音を追加しました Library [Minim](https://github.com/ddf/Minim)　インストール方法は[こ↑こ↓](http://wiki.bmoon.jp/wiki.cgi/Programming?page=%B2%BB%A4%F2%BB%C8%A4%A6)  使った音源 https://maou.audio/
- f345b8b2c0a331d7a0f4e8a21a9e4aa61914aec7　　　ステージエディターとか簡易的なwebを追加（ステージエディターはまだscriptを入れていないため動かない）
- 523fa315a8e19a9620cd0ae8aab17ca1f43cb670　　　Json形式の対応をしてもらいました...
- 789bdcace9233da4ff0a48c433cc1c0aa721ca7a　　　Webツールを作り上げた(PCのみ スマホだと形が崩れる)with Jquery https://jquery.com/
