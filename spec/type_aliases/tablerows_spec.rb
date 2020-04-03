require 'spec_helper'

describe 'TableRows' do
  it { is_expected.to allow_value('square') }
  it { is_expected.not_to allow_value('circle') }
end
