require 'fileutils'

class EmojiGenerator
  ASSET_FILE_NAME = 'asset.txt'.freeze

  def initialize(**options)
    @options = options
    if options[:output].nil?
      @options[:output] = options[:text].split(' ').join('_') + '.png'
    end
  end

  def generate_emoji
    generate_asset_file(@options[:text])

    cmd = build_cmd
    if exec_cmd(cmd)
      display_success_message
    else
      display_error_message
    end
  end

  private

  def exec_cmd(cmd)
    system(cmd)
  end

  def build_cmd
    cmd = '$(which convert)'
    cmd += " -size #{@options[:emoji_size]}"
    cmd += " xc:#{@options[:bg_color]}"
    cmd += " -pointsize #{@options[:font_size]}"
    cmd += " -fill #{@options[:text_color]}"
    cmd += " -draw @#{ASSET_FILE_NAME}"
    cmd += " ./outputs/#{@options[:output]}"

    cmd
  end

  def generate_asset_file(text)
    content = 'text 1,1 "' + "\n" + text
    content += "\n" + '"'
    File.open("./#{ASSET_FILE_NAME}", 'w') do |file|
      file.write(content)
    end
  end

  def display_success_message
    puts 'Output succeeded', "#{Dir.pwd}/outputs/#{@options[:output]}"
  end

  def display_error_message
    puts 'Output failed. Pls check permission.'
  end
end
