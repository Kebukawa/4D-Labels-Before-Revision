# Labels

バグ修正前の状態で印刷するするため、バグ修正の影響を無くすことが目的。

> 参考記事
> > [miyako add v17 R6 compatible mode](https://github.com/4d/4D-Labels/tree/11a76fd8425175efb8b7bdde887897a8d8e0507c)<br/>
> > [4d-tips-fix-label-editor](https://github.com/4D-JP/4d-tips-fix-label-editor)

## 注意事項

本プログラムは、４Ｄのプロジェクトモードで作成されていますので、4D v18以降のバージョンでのご利用が可能です。

プログラムのダウンロードは、本リポジトリのページ右上にある緑色の`<>Code`を押してダウンロードすることができます。
ダウンロードしてご利用される際は、本プログラムは適時修正が行われる予定ですので、最新のものをダウンロードされてお使いくださいますようお願い申し上げます。

## インストール

本プログラムは、コンポーネントとして作成してあります。コンポーネントは、基本的にビルドして利用しますが、プロジェクトのままコンポーネントとしてインストールすることも可能です。

プロジェクトのままコンポーネントとして利用される場合には、[`Project`](./Project)フォルダにある[`Labels.4DProject`](./Project/Labels.4DProject)ファイルのエイリアスを作成し、そのエリアスファイルを利用するデータベースの`Components`フォルダーに入れてください。

コンポーネントとしてデータベースにインストールされると、ホストデータベースの`メソッド`ページに`コンポーネント`として`Labels`がリストされます。そして`Labels`コンポーネントの次の２つのメソッドが利用できるようになります。
+ [`LBL_INSTALL`](./Project/Sources/Methods/LBL_INSTALL.4dm)
+ [`LBL_PRINT`](./Project/Sources/Methods/LBL_PRINT.4dm)

`PRINT LABEL`コマンドの代わりに`LBL_PRINT`を使うように、すべてのメソッドを書き換える必要がありますが、手作業で行わずとも`LBL_INSTALL`メソッドを実行することで、すべてのメソッド中にある`PRINT LABEL`コマンドを書き換えることができます。
すべての`PRINT LABEL`コマンドを書き換えたなら、インストールの完了になります。

## オリジナルからの変更点

+ プロジェクトメソッドの`Print_label`の代わりに`LBL_Print_label`を設けて、`Print_label`の修正前の状況を再現
+ `C_OPEN_EDITOR.4dm`のホストへの公開を非公開にして`LBL_C_OPEN_EDITOR.4dm`とした
+ `C_Print_label.4dm`のホストへの公開を非公開にして`LBL_C_Print_label.4dm`とした
+ `LABEL_WIZARD`フォームの`toolber.prebiew`オブジェクトのオブジェクトメソッドの`Print_label`呼び出しを`LBL_Print_label`に変更
+ `LABEL_WIZARD`フォームの`toolber.print`オブジェクトのオブジェクトメソッドの`Print_label`呼び出しを`LBL_Print_label`に変更
+ `OBJECT SET VALUE`コマンドが`4D v18`に無いので、`4D v18`のときは、`Object get pointer`を使うようにした
+ `FORM Get color scheme`コマンドが`4D v18`に無いので、`4D v18`のときは、スルーするようにした
