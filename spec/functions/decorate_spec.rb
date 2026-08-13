# frozen_string_literal: true

require 'spec_helper'

describe 'format::decorate' do
  cases = [
    [['bold'], "\e[1mstring\e[22m"],
    [['b'], "\e[1mstring\e[22m"],
    [['dim'], "\e[2mstring\e[22m"],
    [['italic'], "\e[3mstring\e[23m"],
    [['i'], "\e[3mstring\e[23m"],
    [['underscore'], "\e[4mstring\e[24m"],
    [['underline'], "\e[4mstring\e[24m"],
    [['u'], "\e[4mstring\e[24m"],
    [['blink_slow'], "\e[5mstring\e[25m"],
    [['blink'], "\e[5mstring\e[25m"],
    [['blink_rapid'], "\e[6mstring\e[26m"],
    [['reverse'], "\e[7mstring\e[27m"],
    [['inverse'], "\e[7mstring\e[27m"],
    [['conceal'], "\e[8mstring\e[28m"],
    [['hide'], "\e[8mstring\e[28m"],
    [['strikethrough'], "\e[9mstring\e[29m"],
    [['s'], "\e[9mstring\e[29m"],
    [['double_underscore'], "\e[21mstring\e[24m"],
    [['double_underline'], "\e[21mstring\e[24m"],
    [['du'], "\e[21mstring\e[24m"],
    [['overline'], "\e[53mstring\e[55m"],
    [%w[s u i b overline], "\e[9;4;3;1;53mstring\e[55;22;23;24;29m"],
  ]
  cases.each do |args, result|
    it { is_expected.to run.with_params('string', args).and_return(result) }
  end
end
