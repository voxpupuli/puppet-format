begin
  require 'terminal-table'
rescue LoadError => e
  Puppet.error("Terminal-table gem not found, please install: gem install terminal-table")
end

# @summary Turns arrays into a table formatted string for human consumption
#
#
# Useful when dumping text to the console in a nice table format.  Normally this would
# only be used for puppet types like plans and other scenarios where text can be displayed
# directory on the console.
# @See https://github.com/tj/terminal-table for more information.
#
# @example Calling the function
#   $t = format::table([['one', 1], ['two', 2]])
#
# @example Calling the function with more parameters
#   $rows = [['one', 1], ['two', 2]]
#   $t_style = {width => 80}
#   $t = format::table({'title' => 'Some title', 'rows' => rows, 'style' => $t_style })
#
# @note For a list of style options that can be supplied please see the tablestyle datatype.
Puppet::Functions.create_function(:'format::table') do
  default_table_width = 40

  # @param rows That data you wish to transform into a table.
  # @return [String] A formatted table in string form. 
  # @example Calling the function
  #   $t = format::table([['one', 1], ['two', 2]])
  #   => "+-----+---+\n| One | 1 |\n| Two | 2 |\n+-----+---+"
  # @note This function wraps the terminal-table gem and has almost the same API.
  #       For more information about how to create tables, please see the gem documention
  #       https://github.com/tj/terminal-table
  dispatch :print_table do
    param 'Format::TableRows', :rows
  end

  # @param data That data and other settings you wish to produce a table with.
  # @return [String] A formatted table in string form. 
  # @example Calling the function
  #   $rows = [['one', 1], ['two', 2]]
  #   $t = format::table({'title' => 'Some title', 'rows' => rows, 'style' => {width => 80}})
  #   => "+-----+---+\n|  title  |\n+-----+---+\n| One | 1 |\n| Two | 2 |\n+-----+---+"
  # @note This function wraps the terminal-table gem and has almost the same API.
  #       For more information about how to create tables, please see the gem documention
  #       https://github.com/tj/terminal-table
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
