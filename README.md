# suiren (睡蓮)
suiren はコマンドを HTTP リクエストを表示するコマンドです。

## インストールについて
### gem のインストール

```bash
gem install suiren
```

### パッケージに追加
```bash
bundle add suiren
```

## 使用法
suiren は日本語と英語と台湾語に対応しています。

日本語で使用する場合:

```bash
LANG=ja_JP.UTF-8 suiren
```

英語で使用する場合:

```bash
LANG= suiren
```

台湾語で使用する場合:

```bash
LANG=zh_TW.UTF-8 bundle exec suiren
```

システムの言語が優先されます。

### 使い方を見る
```bash
$ suiren -h
Usage: suiren [options]
    -V, --version                    バージョン情報を表示します
        --license                    ライセンス情報を表示します
        --bind-address [Bind Address]
                                     Bind アドレスを設定します
    -p, --port [Port]                ポート番号
    -c, --content [Content]          返信するコンテンツを設定します
```

## 貢献

バグレポートとプルリクエストは https://GitHub.com/Himeyama/suiren で行うことができます。

## ライセンス

この gem は、[MIT ライセンス](https://opensource.org/licenses/MIT) の条件の下でオープンソースとして利用できます。
