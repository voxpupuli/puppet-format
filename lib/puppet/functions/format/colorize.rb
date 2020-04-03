Puppet::Functions.create_function(:'format::colorize') do
  dispatch :colorize do
    param 'String', :data
    param 'Enum[
      red, green, yellow, warning, fatal, good
    ]', :color_code
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
    colorize_hex(data,33)
  end
end
