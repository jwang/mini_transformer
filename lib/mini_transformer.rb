require 'rbconfig'
require 'fileutils'
require 'open-uri'
require 'json'
require 'yaml'
require 'nokogiri'
require 'active_support/inflector' # added for .underscore and .dasherize
require "thor"
require "mini_transformer/version"
require "mini_transformer/cli"
require "mini_transformer/book"
require "mini_transformer/key_list"
require "mini_transformer/entry"
require "mini_transformer/html"

module MiniTransformer
  class Parser
    def setup(json_input_filename, xml_input_filename, output=nil, format="html", mapping=nil)
      if File.exists?(xml_input_filename) && File.exists?(json_input_filename)
        xml_input_file = File.open(xml_input_filename)
        json_input = File.open(json_input_filename)
        json_contents = ""
        json_input.each do |line|
          json_contents = json_contents + line
        end
        json_data = JSON.parse json_contents

        if File.extname(xml_input_filename) == ".xml"
          @document = Nokogiri::XML(xml_input_file, nil, 'UTF-8')
        end
      else
        raise "File Not Found."
      end

      unless output.nil?
        # set up the ouput HTML file to write to
        @output = output
      end

      unless mapping.nil?
        @mapping = open(mapping) {|f| YAML.load(f) }
      end

      @book = Book.new
      @book.key_list = KeyList.new

      @book.title = json_data["title"] if json_data["title"]
      @book.type = json_data["type"] if json_data["type"]
      @book.uid = json_data["uid"] if json_data["uid"]

      xml_input_file.close
      json_input.close
    end

    def validate
      if !@document.errors.empty?
        raise "Malformed XML"
      end
      @document.errors
    end

    def parse
      @book.id = @document.root.attribute_nodes.first.content if @document.root.attribute_nodes.size > 0
      @book.introduction = @document.xpath("//Book//Introduction//Para")

      keylist = @document.xpath("//Book//KeyList")
      entries = @document.xpath("//Book//KeyList//Entries")

      @book.key_list.name = keylist.at_xpath("//Name").text
      @book.key_list.key_label = keylist.at_xpath("//KeyLabel").text
      @book.key_list.description_label = keylist.at_xpath("//DescriptionLabel").text
      @book.key_list.entries = Array.new

      entries.children.each do |entry|
        if entry.class == Nokogiri::XML::Element
          book_entry = Entry.new
          entry.children.each do |child|
            if child.class == Nokogiri::XML::Element
              if child.name == "KeyName"
                book_entry.key_name = child.content
              elsif child.name == "Description"
                book_entry.description = child.content
              end
            end
          end
          @book.key_list.entries << book_entry
        end
      end
    end

    def to_json
      json = JSON.pretty_generate @book
      # Save the JSON file
      if @output
        File.open(@output, "w") { |f| f << json }
      else
        if @book.uid.nil?
          File.open("output.json", "w") { |f| f << json }
        else
          File.open("#{@book.uid}.json", "w") { |f| f << json }
        end
      end
    end

    def to_html
      html = MiniTransformer::generate_html(@book, @mapping)

      # Save the HTML file
      if @output
        File.open(@output, "w") { |f| f << html }
      else
        if @book.uid.nil?
          File.open("output.html", "w") { |f| f << html }
        else
          File.open("#{@book.uid}.html", "w") { |f| f << html }
        end
      end

      # return the HTML file as a string
      html
    end

  end
end
