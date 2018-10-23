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
    formatted_text, one_row_length = format_text_row_and_column(@options[:text])
    generate_asset_file(formatted_text)
    set_text_font_size(one_row_length)

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
    cmd += " -font #{@options[:font]}"
    cmd += " -pointsize #{@options[:font_size]}"
    cmd += " -fill #{@options[:text_color]}"
    cmd += " -draw @#{ASSET_FILE_NAME}"
    cmd += " ./outputs/#{@options[:output]}"

    cmd
  end

  def generate_asset_file(text)
    content = 'text 1,1 "' + "\n"
    content += text
    content += "\n" + '"'
    File.open("./#{ASSET_FILE_NAME}", 'w') do |file|
      file.write(content)
    end
  end

  def display_success_message
    file_path = "#{Dir.pwd}/outputs/#{@options[:output]}"
    puts 'Output succeeded', file_path
    `open #{file_path}`
  end

  def display_error_message
    puts 'Output failed. Pls check permission.'
  end

  def format_text_row_and_column(original_text)
    text_length = original_text.size
    one_row_length = [text_length > 3 ? Math.sqrt(text_length).ceil : text_length, 6].min

    [original_text.scan(/.{1,#{one_row_length}}/).join("\n"), one_row_length]
  end

  def set_text_font_size(one_row_length)
    horizontal_size = @options[:emoji_size].split('x').first.to_i
    text_size_in_px = horizontal_size / one_row_length.to_f
    text_size_in_pt = px_to_pt(text_size_in_px)
    @options[:font_size] = text_size_in_pt.to_s
  end

  def px_to_pt(pixels)
    (pixels * 0.75).ceil
  end
end
