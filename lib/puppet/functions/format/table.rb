begin
  require 'terminal-table'
rescue LoadError => e
  Puppet.error("Terminal-table gem not found, please install: gem install terminal-table")
end
# extremely helpful documentation
# https://github.com/puppetlabs/puppet-specifications/blob/master/language/func-api.md#the-4x-api
Puppet::Functions.create_function(:'format::table') do
  default_table_width = 40

  dispatch :print_table do
    param 'Format::TableRows', :rows
  end

  dispatch :print_table_hash do
    param 'Format::TerminalTable', :data
  end

  def print_table(rows)
    table = Terminal::Table.new do |t|
      t.rows = rows
    end
    table.to_s
  end

  def print_table_hash(data)
    tdata = data.transform_keys(&:to_sym)
    table = Terminal::Table.new do |t|
      t.rows = tdata[:rows]
      t.title = tdata[:title]
      t.headings = tdata[:head] if tdata[:head]
      t.style = tdata[:style].transform_keys(&:to_sym) if tdata[:style]
    end
    table.to_s
  end

end
