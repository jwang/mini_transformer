Mini Transformer - [![Build Status](https://secure.travis-ci.org/jwang/mini_transformer.png)](http://travis-ci.org/jwang/mini_transformer)

# Description
Wed Oct 26 18:14:16 PDT 2011

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

## License
MIT License. Copyright 2011 John T Wang