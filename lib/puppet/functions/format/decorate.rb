# frozen_string_literal: true

# @summary Turns any string into a string with font effects applied
#
# To only be used in puppet plans and other scenarios, where text can be
# displayed directly on the console.
#
Puppet::Functions.create_function(:'format::decorate') do
  # @param data The string you wish to decorate.
  # @param effects The array of font effects to apply.
  # @return [String] The supplied string surrounded with font effect codes.
  #
  # @example Calling the function
  #   $bold_string = format::decorate('hello', ['bold']) # or 'b'
  #   $dim_string = format::decorate('hello', ['dim'])
  #   $italic_string = format::decorate('hello', ['italic']) # or 'i'
  #   $underscored_string = format::decorate('hello', ['underscore']) # or 'u'
  #   $slowly_blinking_string = format::decorate('hello', ['blink'])
  #   $rapidly_blinking_string = format::decorate('hello', ['blink_rapid'])
  #   $inversed_string = format::decorate('hello', ['inverse'])
  #   $concealed_string = format::decorate('hello', ['conceal'])
  #   $strikedthrough_string = format::decorate('hello', ['strikethrough']) # or 's'
  #   $double_underlined_string = format::decorate('hello', ['double_underscore'])
  #   $overlined_string = format::decorate('hello', ['overline'])
  #
  dispatch :decorate do
    param 'String', :data
    param 'Array[Format::FontEffect]', :effects
    return_type 'String'
  end

  def effect_to_codes(effect_code)
    code_map = {
      'b' => :bold,
      'i' => :italic,
      'underscore' => :underline,
      'u' => :underline,
      'blink_slow' => :blink,
      'inverse' => :reverse,
      'hide' => :conceal,
      's' => :strikethrough,
      'double_underscore' => :double_underline,
      'du' => :double_underline,
    }

    onoff_codes = {
      bold: [1, 22],
      dim: [2, 22],
      italic: [3, 23],
      underline: [4, 24],
      blink: [5, 25],
      blink_rapid: [6, 26],
      reverse: [7, 27],
      conceal: [8, 28],
      strikethrough: [9, 29],
      double_underline: [21, 24],
      overline: [53, 55],
    }

    ncode = code_map.fetch(effect_code, effect_code.to_sym)
    onoff_codes[ncode] # In Enum[] we trust!
  end

  # See the link below for more info on the ANSI escape sequences:
  # https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
  def decorate(data, effects = [])
    n = effects.size
    ons = Array.new(n)
    offs = Array.new(n)
    i = 0
    j = n - 1
    while j >= 0
      ons[i], offs[j] = effect_to_codes(effects[i])
      i += 1
      j -= 1
    end

    "\e[#{ons.join(';')}m#{data}\e[#{offs.join(';')}m"
  end
end
