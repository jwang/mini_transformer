# Mini Transformer - [![Build Status](https://secure.travis-ci.org/jwang/mini_transformer.png)](http://travis-ci.org/jwang/mini_transformer)

# Description
Mini Transformer takes a pair of input files, JSON and XML, then converts it to HTML5 or JSON format. It also supports a mapping of the children elements to HTML elements via YAML mapping file.

# Installation
`gem install mini_transformer`

## Usage
`mini_transform transform [JSON, XML, OUTPUT=nil, FORMAT=html, MAPPING=nil]`

Requires the json and xml file names, if neither is provided or found, a File Not Found error will occur.

#### Options
* An output file name such as output.html. Defaults to UID tag or output if not available.
* 2 different output formats supported, html or json. Defaults to html.
* A YAML mapping configuration file for the entries tags to convert to HTML tags. Only available for html output format. Defaults to dt and dd tags.

#### Example Usage
`mini_transform transform input.json, input.xml`  
`mini_transform transform input.json, input.xml, out.json, json`  
`mini_transform transform input.json, input.xml, nil, json`  
`mini_transform transform input.json, input.xml, out.html, html, mapping.yml`  
`mini_transform transform input.json, input.xml, nil, html, mapping.yml`

#### Configuration
Example Mapping YAML - mapping.yml  
`entries: dl  
key-name: dt  
key-description: dd`

## Dependencies
* [Nokogiri](nokogiri.org)
* ActiveSupport
* [JSON](http://flori.github.com/json)
* [Thor](https://github.com/wycats/thor)

### Development Dependencies
* [RSpec 2](https://www.relishapp.com/rspec)
* [guard](https://github.com/guard/guard)
* [guard-rspec](https://github.com/guard/guard-rspec)
* [simplecov](https://github.com/colszowka/simplecov)
* rb-fsevent (Mac OSX only)
* [growl_notify (Mac OSX only)](https://github.com/scottdavis/growl_notify)

### Additional Information
* [Test Coverage](http://johntwang.com/mini_transformer/coverage)
* [Travis CI Build Status](http://travis-ci.org/jwang/mini_transformer)


#### Known Issues
* Ruby 1.8.7 alphabetizes the meta tags. Meaning :id and :content are swapped when written to file.


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