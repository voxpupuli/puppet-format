 type Format::TerminalTable = Struct[{
  title => Optional[String],
  head => Optional[Array[String]],
  rows => Format::TableRows,
  style => Optional[Format::TableStyle]
  }
]
