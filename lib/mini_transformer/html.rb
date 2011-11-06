module MiniTransformer

  def self.generate_html(resource, mapping=nil)
    #puts "generate html"
    builder = Nokogiri::HTML::Builder.new(:encoding => 'utf-8') do |doc|
      doc.html(:lang=> "en") {
        doc.head {
          doc.meta(:id => "book-resource-type", :content => resource.type)
          doc.meta(:id => "identifier", :content => "//apple_ref/doc/uid/#{resource.uid}")
          doc.title(resource.title)
        }

        doc.body() {
          doc.header {
            doc.text "\n"
            resource.introduction.children.each do |para|
              doc.p(para.text)
            end
            doc.text "\n"
          }

          doc.text "\n"

          doc.details {
            doc.text "\n"
            doc.summary(:class => "key-list-name") {doc.text resource.key_list.name}
            doc.text "\n"
          }

          doc.div(:class => "key-list") {
            doc.text "\n"
            doc.span(:class => "key-label") {
              doc.text resource.key_list.key_label
            }
            doc.text "\n"
            doc.span(:class => "description-label") {
              doc.text resource.key_list.description_label
            }
            doc.text "\n"

            if mapping
              doc.send(mapping['entries'], :class => 'entries') {
                resource.key_list.entries.each do |entry|
                  if mapping['entry']
                    doc.send(mapping['entry'], :class => 'entry') {
                      doc.send(mapping['key-name'], :class => 'key-name') {
                        doc.text entry.key_name
                      }
                      doc.send(mapping['key-description'], :class => 'key-description') {
                        doc.text entry.description
                      }
                    }
                  else
                    doc.send(mapping['key-name'], :class => 'key-name') {
                      doc.text entry.key_name
                    }
                    doc.send(mapping['key-description'], :class => 'key-description') {
                      doc.text entry.description
                    }
                  end
                end
              }
            else
              doc.dl(:class => "entries") {
                resource.key_list.entries.each do |entry|
                  doc.dt(:class => 'key-name') {
                    doc.text entry.key_name
                  }
                  doc.dd(:class => 'key-description') {
                    doc.text entry.description
                  }
                end
              }
            end
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
    
    # Realign the meta tag that is added by the XSLT transform with Nokogiri
    html = html.gsub(/<meta http-equiv=\"Content-Type\" content=\"text\/html; charset=UTF-8\">\s+$/, '    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">')
    html = html.gsub(/UTF-8/, 'utf-8')
  end

end