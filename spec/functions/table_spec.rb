require 'spec_helper'

describe 'format::table' do
  let(:rows) do
    [['One', 1], ['Two', 2]]
  end

  describe 'without terminal table', if: Bundler.rubygems.find_name('terminal-table').none? do
    it { is_expected.to run.with_params(rows).and_raise_error(LoadError, %r{Terminal-table gem not found}) }
  end

  describe 'with terminal table', if: Bundler.rubygems.find_name('terminal-table').any? do
    it { is_expected.to run.with_params(rows).and_return("+-----+---+\n| One | 1 |\n| Two | 2 |\n+-----+---+") }
    it {
      is_expected.to run.with_params('title' => 'title', 'rows' => rows).
        and_return("+---------+\n|  title  |\n+-----+---+\n| One | 1 |\n| Two | 2 |\n+-----+---+")
    }
  end
end
