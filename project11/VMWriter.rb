class VMWriter
	def initialize(output)
		@output = output
	end
	
	def write_push(segment, index)
		@output.write("push " + segment.to_s + " " + index.to_s + "\n")
	end
	
	def write_pop(segment, index)
		@output.write("pop " + segment.to_s + " " + index.to_s + "\n")
	end
	
	def write_arithmetic(command)
		@output.write(command.to_s + "\n")
	end
	
	def write_label(label)
		@output.write("label " + label.to_s + "\n")
	end
	
	def write_goto(label)
		@output.write("goto " + label.to_s + "\n")
	end
	
	def write_if(label)
		@output.write("if-goto " + label.to_s + "\n")
	end
	
	def write_call(name, nArgs)
		@output.write("call " + name.to_s + " " + nArgs.to_s + "\n")
	end
	
	def write_function(name, nLocals)
		@output.write("function " + name.to_s + " " + nLocals.to_s + "\n")		
	end
	
	def write_return
		@output.write("return\n")
	end

end