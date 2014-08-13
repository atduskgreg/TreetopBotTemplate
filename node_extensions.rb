module PosTemplate
	class Word < Treetop::Runtime::SyntaxNode
		def to_array
			return {:word => self.text_value}
		end
	end

	class TemplateTag < Treetop::Runtime::SyntaxNode
		def to_array
			parts = self.text_value.gsub(/<|>/, "").split(":")
			return {:tag => {:pos => parts[0], :original => parts[1]}}
		end
	end

	class Sentence < Treetop::Runtime::SyntaxNode
		def to_array
       		return self.elements.collect(&:to_array)
     	end
	end

	class Other < Treetop::Runtime::SyntaxNode
		def to_array
			return {:other => self.text_value}
		end
	end
end