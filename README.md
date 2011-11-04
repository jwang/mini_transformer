# Mini Transformer - [![Build Status](https://secure.travis-ci.org/jwang/mini_transformer.png)](http://travis-ci.org/jwang/mini_transformer)

# Description

Create a ruby gem that uses the nokogiri gem
(https://github.com/tenderlove/nokogiri) to convert the data in
  'input/input.xml'
  'input/input.json'
into the 'output/TP40010215.html' file.

Provide as close to full unit test coverage as you reasonably can.
Make sure to include negative tests, not just tests for the normal
cases.

Make the mappings as configurable as you reasonably can.  For
example, make it as easy as you can to change the output to use
different classes for some elements, or even to change the output
of the list from a <dl> to a two-column table.  The intent is that
someone other than  a ruby programmer (e.g. a UI designer) will
make most of the changes to the mappings.

Consider adding the ability to produce more than one kind of output,
for example, both the HTML5 and some sort of pure-JSON output.

# Installation
`gem install mini_transformer`

## Getting Started


## Dependencies
* Nokogiri

### Development Dependencies
* RSpec
* guard
* guard-rspec
* simplecov
* rb-fsevent (Mac OSX only)
* growl_notify (Mac OSX only)

### Additional Information
* [Test Coverage]()
* [Travis CI Build Status](http://travis-ci.org/jwang/mini_transformer)

## MIT License
Copyright (c) 2011 John Wang, http://johntwang.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.