# HobbyRecord

# 紹介

自分には趣味がたくさんあり、それらを一元管理したかったので、このアプリを作成しました。

自分の趣味の継続度、内容などをカレンダー形式で確認できるので、見ていて楽しいです。

開発期間は3週間弱です。

# 苦労したところ、頑張ったところ
- カレンダーの作成
- カレンダーに記録を関連付け
- 画面レイアウト

# 妥協点
- Appleのカレンダーのような無限カレンダーの作成
- SwiftUIのバグによる日本語入力の不具合に対処できなかったこと

# 機能
- 趣味を登録、編集、削除
- カレンダー形式でどの日に何をやったかを見られる

# 開発環境
- 開発言語 : Swift  
- フレームワーク : SwiftUI  
- 設計 : MVVM + Combine  
- データベース : Firebase(Cloud FireStore)
- ユーザー認証 : 匿名認証
- パッケージ管理 : Cocoapods  
- バージョン管理 : Git  

# オープンソースライブラリ
- Firebase/Analytics
- Firebase/Firestore
- Firebase/Auth
- FirebaseFirestoreSwift
- IQKeyboardManagerSwift
- WaterfallGrid
