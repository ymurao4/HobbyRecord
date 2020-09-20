# HobbyRecord

# 紹介

自分には趣味がたくさんあり、それらを一元管理したかったので、このアプリを作成しました。

自分の趣味の継続度、内容などをカレンダー形式で確認できるので、見ていて楽しいです。

開発期間は3週間弱です。

# 機能
- 趣味の記録をメモと共にカレンダーに登録、削除、編集、表示
- ダークモード 対応


# 苦労したところ、頑張ったところ
- カレンダーの作成
- カレンダーに記録を関連付け
- 画面レイアウト


# 妥協点
- Appleのカレンダーのような無限カレンダーの作成
- SwiftUIのバグによる日本語入力の不具合に対処できなかったこと -> 対処しました。
- Navigationbarが消えたりするバグに対処できなかったこと -> 対処しました。


# 機能
- 趣味を登録、編集、削除
- カレンダー形式でどの日に何をやったかを見られる
- 日本語、英語の2カ国語に対応


# 開発環境
- 開発言語 : Swift  
- フレームワーク : SwiftUI, Combine  
- 設計 : MVVM
- データベース : Firebase(Cloud FireStore)
- ユーザー認証 : 匿名認証
- パッケージ管理 : Cocoapods  
- バージョン管理 : Git  


# mBaaS
- Firebase/Analytics
- Firebase/Firestore
- Firebase/Auth
- FirebaseFirestoreSwift


# ライブラリ
- IQKeyboardManagerSwift
- WaterfallGrid

# 追記(2020/9/20)
ios14に対応しました。
バグを修正しました。


<img src="gif/add.gif" width=320px>
<img src="gif/update.gif" width=320px>
<img src="gif/Browse.gif" width=320px>
<img src="gif/addRec.gif" width=320px>
<img src="gif/UpdateRec.gif" width=320px>
<img src="gif/Setting.gif" width=320px>

