# slack_emoji_generator
Generate slack emoji by command

![slack emoji generator demo](imgs/slack_emoji_generator_demo.gif)

## Why this tool?
Sometime one emoji is better than lines of chatting.

![one emoji is better than lines of chatting](imgs/one_emoji_is_better_than_chatting.png)

## Install

- Install [ImageMagick](https://www.imagemagick.org/script/download.php)
- Check supporting font by:
  - `$convert -list font` or
  - `$magick convert -list font`
  - The result of command is something like:
  ```
  Path: /usr/local/Cellar/imagemagick/7.0.8-7/etc/ImageMagick-7/type-apple.xml
  Font: AndaleMono
    family: Andale Mono
    style: Undefined
    stretch: Undefined
    weight: 0
    glyphs: /Library/Fonts//Andale Mono.ttf
  Font: AppleChancery
    family: Apple Chancery
    style: Undefined
    stretch: Undefined
    weight: 0
    glyphs: /Library/Fonts//Apple Chancery.ttf

    ...
    ```

## Usage

```
# Clone source code for first time
$git clone https://github.com/manhdaovan/slack_emoji_generator.git
$cd /path/to/slack_emoji_generator
$ruby slack_emoji.rb [-bfostzh] "text"

Options:
  -b: Emoji background color. Default: transparent
  -f: Emoji font size. Default: 15
  -o: Emoji output file. Default: input_text.png
  -s: Emoji size (horizontal x vertical) in px. Default: 60x60
  -t: Emoji text color. Default: pink
  -z: Emoji text font. Default: ArialUnicode
  -h: Print help message

Example:
$ruby slack_emoji.rb -b white -f 20 -s 100x100 -t black "this is text in emoji" -o slack_emoji_output.png
```

See `$ruby slack_emoji.rb -h` for more details

## Troubleshooting

### 1. My generated image is all of question mark (?) characters
- Use above command to check supporting fonts on your machine, then use `-z` option.
  - Example: `$ruby slack_emoji.rb -z AndaleMono "hura"`
