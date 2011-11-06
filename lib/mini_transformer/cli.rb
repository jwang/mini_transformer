module MiniTransformer
  class CLI < Thor
    include Thor::Actions
    
    desc "transform [input.json, input.xml, output.html, format, mapping.yml]", "Transform the files into format"
    def transform(json, xml, output=nil, format="html", mapping=nil)
      if output.nil?
        output = "#{Dir.pwd}/test.html"
      end

      @parser = MiniTransformer::Parser.new
      @parser.setup(json, xml, output, format, mapping)
      @parser.validate
      @parser.parse

      if format == "json"
        @parser.to_json
      else
        @parser.to_html
      end
      
    end
    map %w(-t --tranform) => :tranform
    
    desc "version", "Prints the bundler's version information"
    def version
      puts "Mini Transform version #{MiniTransformer::VERSION}"
      "Mini Transform version #{MiniTransformer::VERSION}"
      #Bundler.ui.info "Bundler version #{Bundler::VERSION}"
    end
    map %w(-v --version) => :version
  end
end