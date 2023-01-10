# frozen_string_literal: true

# @summary Turns any string into a string with colors
#
#
# Useful when dumping text to the console with flying colors.  Normally this would
# only be used for puppet types like plans and other scenarios where text can be displayed
# directory on the console.
#
# @example Calling the function
#   $red_string = colorize('red alert', red)
#
# @example With a color code
#   $red_string = colorize('red alert', 33)
Puppet::Functions.create_function(:'format::colorize') do
  # @param data The string you wish to colorize.
  # @param color_code The color you want to color it.
  # @return [String] The supplied string surrounded with color codes.
  # @example Calling the function
  #   colorize('hi', red)
  #   colorize('red alert', fatal)
  dispatch :colorize do
    param 'String', :data
    param 'Enum[red, green, yellow, warning, fatal, good]', :color_code
  end

  # @param data The string you wish to colorize.
  # @param color_code The color you want to color it.
  # @return [String] The supplied string surrounded with color codes.
  # @example Calling the function
  #   colorize('red alert', red)
  #   colorize('red alert', 33)
  # @note Please see this article for supplying a custom color code
  #       https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
  dispatch :colorize_hex do
    param 'String', :data
    param 'Integer', :color_code
  end

  def colorize_hex(data, color_code)
    "\e[#{color_code}m#{data}\e[0m"
  end

  def colorize(data, color_code)
    send(color_code.to_sym, data)
  end

  def good(data)
    green(data)
  end

  def red(data)
    colorize_hex(data, 31)
  end

  def green(data)
    colorize_hex(data, 32)
  end

  def warning(data)
    yellow(data)
  end

  def fatal(data)
    red(data)
  end

  def yellow(data)
    colorize_hex(data, 33)
  end
end
