require 'spec_helper'

describe 'Format::TerminalTable' do
  it {
    is_expected.to allow_value(
      'rows' => [['one', 1]], 'style' => { 'width' => 60 }
    )
  }
  it { is_expected.not_to allow_value('style' => { 'width' => 60 }) }
end
