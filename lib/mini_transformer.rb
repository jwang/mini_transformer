require 'rbconfig'
require 'fileutils'
require 'open-uri'
require 'json'
require "mini_transformer/version"
require 'nokogiri'
require 'active_support/inflector' # added for .underscore and .dasherize
require "thor"
require "mini_transformer/cli"
require "mini_transformer/book"
require "mini_transformer/key_list"
require "mini_transformer/entry"

module MiniTransformer
  # Your code goes here...
  class Parser
    def setup(json_input_file, xml_input_file, output=nil, format="html", mapping=nil)
      if File.exists?(xml_input_file) && File.exists?(json_input_file)
        xml_input_file = File.open(xml_input_file)
        json_input = File.open(json_input_file)
        json_contents = ""
        json_input.each do |line|
          json_contents = json_contents + line
        end
        json_data = JSON.parse json_contents
        
        if File.extname(xml_input_file) == ".xml"
          @document = Nokogiri::XML(xml_input_file, nil, 'UTF-8')
        end
      else
        raise "File Not Found."
      end

      unless output.nil?
        # set up the ouput HTML file to write to
        @output = output
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


    def to_html
      builder = Nokogiri::HTML::Builder.new(:encoding => 'UTF-8') do |doc|
        doc.html(:lang=> "en") {
          doc.head {
            doc.meta(:id => "book-resource-type", :content => @book.type)
            doc.meta(:id => "identifier", :content => "//apple_ref/doc/uid/#{@book.uid}")
            doc.title(@book.title)
          }

          doc.body() {
            doc.header {
              doc.text "\n"
              @book.introduction.children.each do |para|
                doc.p(para.text)
              end
              doc.text "\n"
            }
            doc.text "\n"
            doc.details {
              doc.text "\n"
              doc.summary(:class => "key-list-name") {doc.text @book.key_list.name}
              doc.text "\n"
            }

            doc.div(:class => "key-list") {
              doc.text "\n"
              doc.span(:class => "key-label") {
                doc.text @book.key_list.key_label
              }
              doc.text "\n"
              doc.span(:class => "description-label") {
                doc.text @book.key_list.description_label
              }
              doc.text "\n"
              doc.dl(:class => "entries") {
                @book.key_list.entries.each do |entry|
                  doc.dt(:class => 'key-name') {
                    doc.text entry.key_name
                  }
                  doc.dd(:class => 'key-description') {
                    doc.text entry.description
                  }
                end
              }
            }
          }
        }
      end

      html = builder.to_html
            
      # Use an XSLT Stylesheet to pretty generate the HTML file. Adjustments follow.
      xsl = Nokogiri::XSLT(File.read(File.join(File.dirname(__FILE__), "format.xsl")))      
      html = xsl.apply_to(Nokogiri::HTML html).to_s
      
      # Nokogiri's HTML Builder creates an HTML4 file and cannot be easily changed due to DTD Validation
      html = html.gsub(/<!DOCTYPE html PUBLIC \"-\/\/W3C\/\/DTD HTML 4.0 Transitional\/\/EN\" \"http:\/\/www.w3.org\/TR\/REC-html40\/loose.dtd">\n/, '<!DOCTYPE html>')
      
      # Realign the meta tag that is added by the XSLT transform
      html = html.gsub(/<meta http-equiv=\"Content-Type\" content=\"text\/html; charset=UTF-8\">\s+$/, '    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">')
      html = html.gsub(/UTF-8/, 'utf-8')
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
