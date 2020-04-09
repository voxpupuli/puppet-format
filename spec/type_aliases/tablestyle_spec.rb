require 'spec_helper'

describe 'Format::TableStyle' do
  it { is_expected.to allow_value('width' => 80) }
  it { is_expected.not_to allow_value('settings' => {}) }
end
