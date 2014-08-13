require 'treetop'

# Find out what our base path is
BASE_PATH = File.expand_path(File.dirname(__FILE__))

# Load our custom syntax node classes so the parser can use them
require File.join(BASE_PATH, 'node_extensions.rb')

class Parser

  Treetop.load(File.join(BASE_PATH, 'postemplate_parser.treetop'))
  @@parser = PosTemplateParser.new
  
  def self.parse(data)
     # Pass the data over to the parser instance
     tree = @@parser.parse(data)
     
     # If the AST is nil then there was an error during parsing
     # we need to report a simple error message to help the user
     if(tree.nil?)
      puts "#{data[@@parser.index]}"
       raise Exception, "Parse error at offset: #{@@parser.index}"

        @@parser.failure_reason =~ /^(Expected .+) after/m
        puts "#{$1.gsub("\n", '$NEWLINE')}:"
        puts data.lines.to_a[parser.failure_line - 1]
        puts "#{'~' * (parser.failure_column - 1)}^"
     end

     self.clean_tree(tree)
     
     return tree.to_array
   end

   private

   def self.clean_tree(root_node)
     return if(root_node.elements.nil?)
     root_node.elements.delete_if{|node| node.class.name == "Treetop::Runtime::SyntaxNode" }
     root_node.elements.each {|node| self.clean_tree(node) }
   end
end