# frozen_string_literal: true

# @summary Indent a block of text
Puppet::Functions.create_function(:'format::indent') do
  # @param text The text you wish to indent.
  # @param indent The string you want to indent the text with.
  # @param options A Hash of additional options
  # @option options [Boolean] ignore_empty Whether to skip indenting empty lines
  # @return [String] The indented text.
  # @example Indent the text with 2 spaces
  #   $indented_text = format::indent($text, '  ')
  # @example Indent the text with 2 spaces ignoring empty lines
  #   $indented_text = format::indent($text, '  ', ignore_empty => true)
  dispatch :indent do
    param 'String', :text
    param 'String', :indent
    optional_param 'Format::IndentOptions', :options
  end

  def indent(text, indent, options = {})
    indent_re = (options['ignore_empty'] ? %r{^(?=.)} : %r{^})
    text.gsub(indent_re, indent)
  end
end
