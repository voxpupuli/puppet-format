# frozen_string_literal: true

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
    print_table_hash('rows' => rows)
  end

  def print_table_hash(data)
    require 'terminal-table'
    tdata = data.transform_keys(&:to_sym)
    table = Terminal::Table.new do |t|
      t.rows = tdata[:rows].empty? ? [tdata[:rows]] : tdata[:rows]
      t.title = tdata[:title]
      t.headings = tdata[:head] if tdata[:head]

      unless tdata[:style].nil?
        style = tdata[:style].transform_keys(&:to_sym)
        style[:border] &&= style[:border].to_sym # This value is required to be a symbol
        t.style = style
      end
    end
    table.to_s
  rescue LoadError
    message = 'Terminal-table gem not found, please install: gem install terminal-table'
    raise LoadError, message
  end
end
