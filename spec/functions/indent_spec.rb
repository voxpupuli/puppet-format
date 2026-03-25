# frozen_string_literal: true

require 'spec_helper'

describe 'format::indent' do
  it { is_expected.to run.with_params("line1\n\n  \nlineX\n", '  ').and_return("  line1\n  \n    \n  lineX\n") }

  context 'with ignore_empty' do
    it { is_expected.to run.with_params("line1\n\n  \nlineX\n", '  ', 'ignore_empty' => true).and_return("  line1\n\n    \n  lineX\n") }
  end
end
