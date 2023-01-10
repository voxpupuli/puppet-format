# frozen_string_literal: true

require 'spec_helper'

describe 'Format::TableRows' do
  it { is_expected.to allow_value([['one', 2], ['two', 2]]) }
  it { is_expected.not_to allow_value('one' => '2') }
end
