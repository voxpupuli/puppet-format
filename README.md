# puppet-format

[![CI](https://github.com/voxpupuli/puppet-format/actions/workflows/ci.yml/badge.svg)](https://github.com/voxpupuli/puppet-format/actions/workflows/ci.yml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/format.svg)](https://forge.puppetlabs.com/puppet/format)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/format.svg)](https://forge.puppetlabs.com/puppet/format)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/format.svg)](https://forge.puppetlabs.com/puppet/format)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/format.svg)](https://forge.puppetlabs.com/puppet/format)
[![Apache-2 License](https://img.shields.io/github/license/voxpupuli/puppet-format.svg)](LICENSE)

This module includes puppet functions to transform your boring, old and worn looking ascii characters into beautiful looking masterpieces.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with format](#setup)
    * [What format affects](#what-format-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with format](#beginning-with-format)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

With this module you can produce amazing looking tables, colorized strings and others transformations for output to the terminal screen.  While this module is mainly for bolt plans it could be used in puppet code anywhere.

## Setup

### What format affects

This module includes functions and datatypes only.

### Setup Requirements

This module requires the `terminal-table` gem. It's a direct dependency for
bolt, so open source users don't need to install additional gems. For PE users
that want to use the function, they need to install terminal-table for the
orchestrator:

```
GEM_PATH=/opt/puppetlabs/server/apps/bolt-server/lib/ruby GEM_HOME=/opt/puppetlabs/server/apps/bolt-server/lib/ruby /opt/puppetlabs/puppet/bin/gem install terminal-table --no-document
```

## Usage

This module only contains functions to format and transform data.  It will not output anything to stdout and only return
formatted data ready to be sent to stdout or stderr.

### Functions

* format::colorize("string", red) # options include red, green, yellow, fatal, warning, good.
* format::table([['one', 1], ['two', 2]])

The print_table function wraps the [Terminal-Table](https://github.com/tj/terminal-table) ruby gem in a function
and tries to provide the same API.  You can create a table in two ways.
  * by passing a TableRows type  (Array of Arrays)
  * by passing a TerminalTable type (Hash of various keys)

Example:

```shell
# puppet code
format::table({title => 'GPU list', head => ['Name', 'QTY'],
               rows => [['GTX 1070', 5], ['GTX 2080 ti', 1]],
               style => {width => 60 }
            })
```

Which produces a table like:


```
+-----------------------------+----------------------------+
|                         GPU list                         |
+-----------------------------+----------------------------+
| Name                        | QTY                        |
+-----------------------------+----------------------------+
| GTX 1070                    | 5                          |
| GTX 2080 ti                 | 1                          |
+-----------------------------+----------------------------+
```

Or with colors

![](https://github.com/voxpupuli/puppet-format/blob/master/images/table_format.png)
