require 'spec_helper'
require 'mini_transformer'
require 'nokogiri'

describe MiniTransformer do
  FIXTURES_DIR = File.join(File.dirname(__FILE__), "fixtures")
  describe "Version" do
    it "should have a version" do
      MiniTransformer::VERSION.should_not be_nil
    end
  end

  describe "Parser" do
    before(:all) do
      @parser = MiniTransformer::Parser.new
      @file = File.new(File.join(FIXTURES_DIR, "input.xml"), 'rb')
      @json = File.new(File.join(FIXTURES_DIR, "input.json"), 'rb')
    end

    it "should Ensure Valid file" do
      badly_formed = <<-EOXML
      <root>
        <open>foo
          <closed>bar</closed>
      </root>
      EOXML

      bad_doc  = Nokogiri::XML badly_formed

    end

    it "should raise exception if passed in a bad file" do
      expect { @parser.setup(@json, "input.xml") }.to raise_error(RuntimeError, "File Not Found.")
    end

    it "should setup with good XML" do
      expect { @parser.setup(@json.path, @file.path) }.to_not raise_error
    end

    it "should validate the XML format before continuing" do
      @parser.setup(@json.path, @file.path)
      @parser.validate.should be_empty
    end

    it "should have errors on invalid XML" do
      @bad_file = File.new(File.join(FIXTURES_DIR, "bad_xml.xml"), 'rb')
      @parser.setup(@json.path, @bad_file.path)
      expect { @parser.validate }.to raise_error(RuntimeError, "Malformed XML")
    end

    it "should parse" do
      @parser.setup(@json, @file)
      @parser.validate
      @parser.parse
    end

    it "should create a HTML doc" do
      @result_file = File.open(File.join(FIXTURES_DIR, "TP40010215.html"), 'rb:UTF-8')
      @parser.setup(@json, @file)
      @parser.validate
      @parser.parse
      
      @result_doc = ""
      @result_file.each do |line|
        @result_doc = @result_doc + line
      end
      @result_file.close
      @parser.to_html.should eq(@result_doc)
      
    end

  end

end
