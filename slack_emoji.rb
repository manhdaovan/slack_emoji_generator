require 'fileutils'
require 'optparse'
require_relative './emoji_generator'

def print_help
  File.open('./help.txt', 'r') do |f|
    f.each { |line| puts line }
  end
end

options = {
  emoji_size: '60x60',
  bg_color: 'transparent',
  font_size: 15,
  text_color: 'pink',
  output: nil
}

begin
  OptionParser.new do |opts|
    opts.on('-h', '--help', 'Print help') do |_v|
      print_help
      exit
    end

    opts.on('-b', '--background=BACKGROUND', 'Emoji background color') do |v|
      options.merge!(bg_color: v.to_s)
    end

    opts.on('-f', '--fontsize=FONTSIZE', 'Emoji font size') do |v|
      options.merge!(font_size: v.to_s)
    end

    opts.on('-o', '--output=OUTPUT', 'Emoji output file') do |v|
      options.merge!(output: v.to_s)
    end

    opts.on('-s', '--esize=ESIZE', 'Emoji size') do |v|
      options.merge!(emoji_size: v)
    end

    opts.on('-t', '--txtcolor=TXTCOLOR', 'Emoji text color') do |v|
      options.merge!(text_color: v)
    end
  end.parse!
rescue StandardError => e
  puts e.message
  puts e.backtrace[0, 10]
  print_help
  exit
end

options[:text] = ARGV[0]

generator = EmojiGenerator.new(**options)
generator.generate_emoji
