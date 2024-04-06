# suiren
suiren 是一個用於顯示 HTTP 請求的命令行工具。

## 安裝
### 安裝 gem

```bash
gem install suiren
```

### 添加到您的專案
```bash
bundle add suiren
```

## 使用方法
suiren 支援台灣語和日語和英語。

要在台灣語中運行，請使用:

```bash
LANG=zh_TW.UTF-8 suiren
```

要在日語中運行，請使用:

```bash
LANG=ja_JP.UTF-8 suiren
```

要在英語中運行，請使用:

```bash
LANG= suiren
```

系統語言覆蓋。

### 查看如何使用
```bash
$ suiren -h
Usage: suiren [options]
    -V, --version                    顯示版本資訊
        --license                    顯示許可證資訊
        --bind-address [Bind Address]
                                     設定綁定地址
    -p, --port [Port]                埠號
    -c, --content [Content]          設定回覆內容
```

## 貢獻

歡迎在 GitHub 上報告錯誤和提交拉取請求：https://github.com/Himeyama/suiren。

## 許可證
該 gem 可根據 [MIT 許可證](https://opensource.org/licenses/MIT) 作為開源軟件使用。