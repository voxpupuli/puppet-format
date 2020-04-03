require 'spec_helper'

describe 'format::colorize' do
  it { is_expected.to run.with_params('string', 'red').and_return("\e[31mstring\e[0m") }
  it { is_expected.to run.with_params('string', 'fatal').and_return("\e[31mstring\e[0m") }

end

