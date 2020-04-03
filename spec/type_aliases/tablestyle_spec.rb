require 'spec_helper'

describe 'TableStyle' do
  it { is_expected.to allow_value('square') }
  it { is_expected.not_to allow_value('circle') }
end
