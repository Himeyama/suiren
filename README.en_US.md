


# suiren
suiren is a command-line tool for displaying HTTP requests.

## Installation
### Install the gem

```bash
gem install suiren
```

### Add to your package
```bash
bundle add suiren
```

## Usage
suiren supports both Japanese and English.

To run it in Japanese, use:

```bash
LANG=ja_JP.UTF-8 suiren
```

To run it in English, use:

```bash
LANG= suiren
```

To run it in Taiwanese, use:

```bash
LANG=zh_TW.UTF-8 suiren
```

System Language Override.

### See how to use
```bash
$ suiren -h
Usage: suiren [options]
    -V, --version                    Display Version Information
        --license                    Display License Information
        --bind-address [Bind Address]
                                     Set Bind Address
    -p, --port [Port]                Port Number
    -c, --content [Content]          Set Content to Reply
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Himeyama/suiren.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
