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
      @parser.setup(@json.path, @file.path)
      @parser.validate
      @parser.parse
    end

    context "HTML" do
      it "should create a HTML doc" do
        @result_file = File.open(File.join(FIXTURES_DIR, "TP40010215.html"), 'rb:UTF-8')
        @parser.setup(@json.path, @file.path)
        @parser.validate
        @parser.parse

        @result_doc = ""
        @result_file.each do |line|
          @result_doc = @result_doc + line
        end
        @result_file.close
        @parser.to_html.should eq(@result_doc)
      end

      it "should create an output.html file if UID is not present in JSON" do
        json_uid = File.new(File.join(FIXTURES_DIR, "no_uid.json"), 'rb')
        @parser.setup(json_uid.path, @file.path)
        @parser.validate
        @parser.parse
        @parser.to_html
        File.exists?('output.html').should be_true
      end

    end

    context "JSON Format" do
      it "should export to JSON with uid if filename is nil" do
        @parser.setup(@json.path, @file.path, nil, 'json')
        @parser.validate
        @parser.parse
        @parser.to_json
        File.exists?('TP40010215.json').should be_true
      end

      it "should export to output.json if no UID exists in json input" do
        json_uid = File.new(File.join(FIXTURES_DIR, "no_uid.json"), 'rb')
        @parser.setup(json_uid.path, @file.path, nil, 'json')
        @parser.validate
        @parser.parse
        @parser.to_json
        File.exists?('output.json').should be_true
      end

      it "should export to JSON if the format specified is 'json'" do
        @parser.setup(@json.path, @file.path, "output.json", 'json')
        @parser.validate
        @parser.parse
        @parser.to_json
        File.exists?('output.json').should be_true
      end

    end

    context "Mappings" do
      it "should accept a valid mapping for the children" do
        mapping = File.open(File.join(FIXTURES_DIR, "mapping.yml"), 'rb:UTF-8')
        @parser.setup(@json.path, @file.path, "altered.html", 'html', mapping.path)
        @parser.validate
        @parser.parse
        @parser.to_html
      end

      it "should accept a valid ol mapping for the children" do
        mapping = File.open(File.join(FIXTURES_DIR, "ol_mapping.yml"), 'rb:UTF-8')
        @parser.setup(@json.path, @file.path, "ol.html", 'html', mapping.path)
        @parser.validate
        @parser.parse
        @parser.to_html
      end

      it "should accept a valid ul mapping for the children" do
        mapping = File.open(File.join(FIXTURES_DIR, "ul_mapping.yml"), 'rb:UTF-8')
        @parser.setup(@json.path, @file.path, "ul.html", 'html', mapping.path)
        @parser.validate
        @parser.parse
        @parser.to_html
      end

      it "should accept a valid table mapping for the children" do
        mapping = File.open(File.join(FIXTURES_DIR, "table_mapping.yml"), 'rb:UTF-8')
        @parser.setup(@json.path, @file.path, "table.html", 'html', mapping.path)
        @parser.validate
        @parser.parse
        @parser.to_html
      end
    end

  end

end
