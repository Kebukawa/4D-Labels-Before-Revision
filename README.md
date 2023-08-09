# Labels

バグ修正前の状態で印刷するするため、バグ修正の影響を無くすことが目的。

> 参考記事
> > [miyako add v17 R6 compatible mode](https://github.com/4d/4D-Labels/tree/11a76fd8425175efb8b7bdde887897a8d8e0507c)<br/>
> > [4d-tips-fix-label-editor](https://github.com/4D-JP/4d-tips-fix-label-editor)


## インストール

インストール用のメソッド[`LBL_INSTALL`](./Project/Sources/Methods/LBL_INSTALL.4dm)を起動して、インストール／アンインストールができます。

インストールを行うと、`PRINT LABEL`コマンドの呼び出しが、[`LBL_PRINT`](./Project/Sources/Methods/LBL_PRINT.4dm)メソッドの呼び出しに変更されます。


## 変更点

+ プロジェクトメソッドの`Print_label`の代わりに`LBL_Print_label`を設けて、`Print_label`の修正前の状況を再現
+ `C_OPEN_EDITOR.4dm`のホストへの公開を非公開にして`LBL_C_OPEN_EDITOR.4dm`とした
+ `C_Print_label.4dm`のホストへの公開を非公開にして`LBL_C_Print_label.4dm`とした
+ `LABEL_WIZARD`フォームの`toolber.prebiew`オブジェクトのオブジェクトメソッドの`Print_label`呼び出しを`LBL_Print_label`に変更
+ `LABEL_WIZARD`フォームの`toolber.print`オブジェクトのオブジェクトメソッドの`Print_label`呼び出しを`LBL_Print_label`に変更
+ `OBJECT SET VALUE`コマンドが`4D v18`に無いので、`4D v18`のときは、`Object get pointer`を使うようにした
+ `FORM Get color scheme`コマンドが`4D v18`に無いので、`4D v18`のときは、スルーするようにした
